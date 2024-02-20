from rest_framework import serializers

from .models import *


class ChildProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = ChildProfile
        fields = "__all__"
        
class ProfileSerializer(serializers.Serializer):
    class Meta:
        model = Profile
        fields = "__all__"

class MedicalRecordSerializer(serializers.Serializer):
    class Meta:
        model = MedicalRecord
        fields = "__all__"

class MedicationSerializer(serializers.Serializer):
    class Meta:
        model = Medication
        fields = "__all__"

class MedicationLogSerializer(serializers.Serializer):
    class Meta:
        model = MedicationLog
        fields = "__all__"

class DietaryRestrictionSerializer(serializers.Serializer):

    class Meta:
        model = DietaryRestriction
        fields = "__all__"