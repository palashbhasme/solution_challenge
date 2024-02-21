from django.contrib.auth import authenticate, login
from rest_framework import status
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.tokens import RefreshToken

from .models import *
from .serializers import *
from .utils import *

# Create your views here.

#Authentication Views
class RegisterUserView(APIView):
    permission_classes = [AllowAny]
    def post(self, request):
            user_serializer = UserSerializer(data=request.data)
            if user_serializer.is_valid():
                user = user_serializer.save()

                # Create profile data
                profile_data = {
                    'user': user.id,
                    'name': request.data.get('name'),
                    'dob': request.data.get('dob'),
                    'email': request.data.get('email'),
                    'phone': request.data.get('phone'),
                    'gender': request.data.get('gender'),
                    'is_volunteer': request.data.get('is_volunteer', False),
                }

                # Serialize profile data
                profile_serializer = ProfileSerializer(data=profile_data)
                if profile_serializer.is_valid():
                    profile_serializer.save()

                    # Create a token for the user
                    refresh = RefreshToken.for_user(user)
                    access_token = str(refresh.access_token)

                    return Response({'message': 'Registration successful and user logged in', 'access_token': access_token}, status=status.HTTP_201_CREATED)

                else:
                    # Delete the user if profile creation fails
                    user.delete()
                    return Response({'error': 'Error creating profile'}, status=status.HTTP_400_BAD_REQUEST)
            else:
                return Response({'error': 'Registration failed'}, status=status.HTTP_400_BAD_REQUEST)


class LoginView(APIView):
    permission_classes = [AllowAny]
    def post(self, request, format=None):
        username = request.data.get("username")
        password = request.data.get("password")
        user = authenticate(request, username=username, password=password)

        if user is not None:
            login(request, user)
            return Response({"message": "Login successful"}, status=status.HTTP_200_OK)
        return Response({"error": "Invalid credentials"}, status=status.HTTP_401_UNAUTHORIZED)

class HomePageAPIView(APIView):
    permission_classes = [IsAuthenticated]
    def get(self,  request):
        user = request.user
        try:
            profile = Profile.objects.get(user = user)
        except Profile.DoesNotExist:
            return Response({"details":"Profile Doesn't exist"}, status= status.HTTP_404_NOT_FOUND)
        profileserializer = ProfileSerializer(profile).data
        childprofile = ChildProfile.objects.filter(profile = profile)
        if childprofile:
            serializer = HomePageSerializer(childprofile, many = True)
            response = {
                "profile_id": profileserializer["id"],
                "profile_name": profileserializer["name"],
                "profile_picture": profileserializer["picture"],
                "childs": serializer.data
            }
        else:
            response = {
                "profile_id": profileserializer["id"],
                "profile_name": profileserializer["name"],
                "profile_picture": profileserializer["picture"],
            }
        return Response(response, status= status.HTTP_200_OK)

class ChildListAPIView(APIView):

    def get(self, request, format = None):
        try:
            profile = Profile.objects.get(user = request.user)
        except Profile.DoesNotExist():
            return Response({"details": "User not found"}, status= status.HTTP_404_NOT_FOUND)
        
        query_set = ChildProfile.objects.filter(profile = profile)
        serialiser = ChildProfileSerializer(query_set, many = True)
        return Response(serialiser.data, status= status.HTTP_200_OK)
class ChildDetailAPIView(APIView):

    def get(self, request,id, format = None):

        try:
            query_set = ChildProfile.objects.get(id = id)
        except ChildProfile.DoesNotExist:
            return Response({"details": "data not found"}, status= status.HTTP_404_NOT_FOUND)
        
        serializer = ChildProfileSerializer(query_set)
        return Response(serializer.data, status= status.HTTP_200_OK)
    
    def post(self, request):
        user = request.user
        profile = Profile.objects.get(user = user)
        serializer = ChildProfileSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(profile = profile)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class DietaryRestrictionsAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, child_id = None):
        user = request.user
        if child_id is None:
            try:
                profile = Profile.objects.get(user = user)
                dietary_restrictions = DietaryRestriction.objects.filter(profile = profile)
            except Profile.DoesNotExist:
                return Response({"details":"Profile doesn't exist"}, status= status.HTTP_404_NOT_FOUND)

        else:
            try:
                child_profile = ChildProfile.objects.get(id = child_id)
                dietary_restrictions = DietaryRestriction.objects.filter(childprofile=child_profile)

            except ChildProfile.DoesNotExist:
                return Response({"details": "Child not found"}, status=status.HTTP_404_NOT_FOUND)
        serializer = DietaryRestrictionSerializer(dietary_restrictions, many = True)

        return Response({"dietaryrestrictions":serializer.data}, status= status.HTTP_200_OK)
    
        
    def post(self, request):

        user = request.user
        childprofile = None

        if "profile_id" in request.data:
            profile_id = request.data["profile_id"]
            try:
                profile = Profile.objects.filter(id = profile_id).first()

            except Profile.DoesNotExist:

                return Response({"details":"Profile doesn't exist"}, status= status.HTTP_404_NOT_FOUND)
        else:
            profile = None
        
        if "child_id" in request.data:
            child_id = request.data["child_id"]
            childprofile = ChildProfile.objects.filter(id=child_id).first()

            if not childprofile:
                return Response({"details": "Child not found"}, status= status.HTTP_404_NOT_FOUND)

        serializer = DietaryRestrictionSerializer(data = request.data)

        if serializer.is_valid():
            if childprofile:

                serializer.save(childprofile = childprofile)
            elif profile:
                serializer.save(profile = profile)
            else:
                return Response({"details": "Profile or child_id is required"}, status=status.HTTP_400_BAD_REQUEST)
            return Response(serializer.data, status= status.HTTP_201_CREATED)
        
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
                
        
class MedicalRecordAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        serializer = MedicalRecordSerializer(data= request.data)
        if serializer.is_valid():
            age = int(request.data["age"])
            height = int(request.data["height"])
            weight = int(request.data["weight"])
            health_status = nutritional_status(age,weight, height)
            if "profile_id" in request.data:
                profile = Profile.objects.get(pk = request.data['profile_id'])
                serializer.save(profile = profile, childprofile = None, health_status = health_status)
            elif "child_id" in request.data:
                childprofile = ChildProfile.objects.get(pk = request.data["child_id"])
                serializer.save(profile = None, childprofile = childprofile, health_status = health_status)
            else:
                return Response({"details": "Invalid request data"}, status=status.HTTP_400_BAD_REQUEST)
            
            return Response(serializer.data ,  status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status= status.HTTP_400_BAD_REQUEST)

    def get(self, request, record_id):
        try:
            queryset = MedicalRecord.objects.get(pk = record_id)
        except MedicalRecord.DoesNotExist:
            return Response({"details":"Record not found"}, status= status.HTTP_404_NOT_FOUND)
        
        serializer = MedicalRecordSerializer(queryset)
        return Response(serializer.data, status= status.HTTP_200_OK)

class MedicalRecordListAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, profile_type, id):
        user = request.user
        if profile_type == "self":
            try:
                profile = Profile.objects.get(pk = id, user = user)
            except Profile.DoesNotExist:
                return Response({"details":"Data not Found"}, status= status.HTTP_404_NOT_FOUND)
            
            try:
                queryset = MedicalRecord.objects.filter(profile = profile)
            except MedicalRecord.DoesNotExist:
                return Response({"details":"Data not Found"}, status= status.HTTP_404_NOT_FOUND)
            
            serializer = MedicalRecordSerializer(queryset, many = True)
            return Response(serializer.data, status= status.HTTP_200_OK)
        
        elif profile_type == "child":
            
            try:
                childprofile = ChildProfile.objects.get(pk = id)
            except Profile.DoesNotExist:
                return Response({"details":"Data not Found"}, status= status.HTTP_404_NOT_FOUND)
            
            try:
                queryset = MedicalRecord.objects.filter(childprofile = childprofile)
            except MedicalRecord.DoesNotExist:
                return Response({"details":"Data not Found"}, status= status.HTTP_404_NOT_FOUND)
            
            serializer = MedicalRecordSerializer(queryset, many = True)
            return Response(serializer.data, status= status.HTTP_200_OK)
        else:
            return Response({"details":"Invalid request"}, status= status.HTTP_400_BAD_REQUEST)

class MedicationAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, child_id = None):
        user = request.user
        if child_id is None:
            try:
                profile = Profile.objects.get(user = user)
                medication = Medication.objects.filter(profile = profile)
            except Profile.DoesNotExist:
                return Response({"details":"Profile doesn't exist"}, status= status.HTTP_404_NOT_FOUND)

        else:
            try:
                child_profile = ChildProfile.objects.get(id = child_id)
                medication = Medication.objects.filter(childprofile=child_profile)

            except ChildProfile.DoesNotExist:
                return Response({"details": "Child not found"}, status=status.HTTP_404_NOT_FOUND)
        serializer = MedicationSerializer(medication, many = True)

        return Response({"medication":serializer.data}, status= status.HTTP_200_OK)
    
        
    def post(self, request):

        user = request.user
        childprofile = None

        if "profile_id" in request.data:
            profile_id = request.data["profile_id"]
            try:
                profile = Profile.objects.filter(id = profile_id).first()

            except Profile.DoesNotExist:

                return Response({"details":"Profile doesn't exist"}, status= status.HTTP_404_NOT_FOUND)
        else:
            profile = None
        
        if "child_id" in request.data:
            child_id = request.data["child_id"]
            childprofile = ChildProfile.objects.filter(id=child_id).first()

            if not childprofile:
                return Response({"details": "Child not found"}, status= status.HTTP_404_NOT_FOUND)

        serializer = MedicationSerializer(data = request.data)

        if serializer.is_valid():
            if childprofile:

                serializer.save(childprofile = childprofile)
            elif profile:
                serializer.save(profile = profile)
            else:
                return Response({"details": "Profile or child_id is required"}, status=status.HTTP_400_BAD_REQUEST)
            return Response(serializer.data, status= status.HTTP_201_CREATED)
        
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)