from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import *
from .serializers import *
from .utils import *

# Create your views here.

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
        serializer = ChildProfileSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class DietaryRestrictionsAPIView(APIView):

    def get(self, request, child_id = None):
        user = request.user
        if child_id is None:
            try:
                profile = Profile.objects.filter(user = user).first()
            except Profile.DoesNotExist:
                return Response({"details":"Profile doesn't exist"}, status= status.HTTP_404_NOT_FOUND)
            
            dietary_restrictions = DietaryRestriction.objects.filter(profile = profile)

        else:

            child_profile = ChildProfile.objects.filter(id = child_id ,profile__user = user).first()
            if child_profile:
                dietary_restrictions = DietaryRestriction.objects.filter(child_profile = child_profile)
            else:
                return Response({"details": "Child not found"}, status= status.HTTP_404_NOT_FOUND)
            
        serializer = DietaryRestrictionSerializer(dietary_restrictions, many = True)

        return Response(serializer.data, status= status.HTTP_200_OK)
    
        
    def post(self, request):

        user = request.user
        child_profile = None
        try:
            profile = Profile.objects.filter(user = user).first()

        except Profile.DoesNotExist:
            return Response({"details":"Profile doesn't exist"}, status= status.HTTP_404_NOT_FOUND)
        

        if "profile_id" in request.data:
            
            serializer = DietaryRestrictionSerializer(data = request.data)

            if serializer.is_valid():

                serializer.save(profile = user)
                return Response(serializer.data, status= status.HTTP_201_CREATED)
            
            else:
                    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        
        if "child_id" in request.data:

            child_profile = ChildProfile.objects.filter(id = request.data["child_id"] ,profile__user = user).first()

            if not child_profile:
                return Response({"details": "Child not found"}, status= status.HTTP_404_NOT_FOUND)

        serializer = DietaryRestrictionSerializer(data = request.data)

        if serializer.is_valid():
            if child_profile:

                serializer.save(child_profile = child_profile)
            else:
                serializer.save(profile = profile)
            return Response(serializer.data, status= status.HTTP_201_CREATED)
        
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
                
        
class MedicalRecordAPIView(APIView):

    def post(self, request):
        serializer = MedicalRecordSerializer(data= request.data)

        if serializer.is_valid():
            age = request.data["age"]
            height = request.data["height"]
            weight = request.data["weight"]
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

    def get(self, request, profile_type, id):

        if profile_type == "self":
            try:
                profile = Profile.objects.get(pk = id)
            except Profile.DoesNotExist:
                return Response({"details":"Data not Found"}, status= status.HTTP_404_NOT_FOUND)
            
            try:
                queryset = MedicalRecord.objects.all(profile = profile)
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
                queryset = MedicalRecord.objects.all(childprofile = childprofile)
            except MedicalRecord.DoesNotExist:
                return Response({"details":"Data not Found"}, status= status.HTTP_404_NOT_FOUND)
            
            serializer = MedicalRecordSerializer(queryset, many = True)
            return Response(serializer.data, status= status.HTTP_200_OK)
        else:
            return Response({"details":"Invalid request"}, status= status.HTTP_400_BAD_REQUEST)
        

