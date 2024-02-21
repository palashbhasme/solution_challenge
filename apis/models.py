from datetime import date, datetime

from django.contrib.auth.models import User
from django.db import models

# Create your models here.


class Profile(models.Model):
    GENDER_CHOICES = (
        ("M", "Male"),
        ("F", "Female"),
        ("O" , "Others"),
        ("X", "No answer")
    )

    name = models.CharField(max_length = 40)
    user = models.OneToOneField(User,on_delete = models.CASCADE)
    picture = models.ImageField(upload_to='profile_pics/', blank=True, null=True)
    dob = models.DateField(blank=True, null=True)
    email = models.CharField(max_length = 20)
    phone = models.CharField(max_length = 15,blank=True, null=True)
    gender = models.CharField(max_length = 1, choices = GENDER_CHOICES)
    is_volunteer = models.BooleanField(default = False)

    def __str__(self) -> str:
        return self.name


class ChildProfile(models.Model):
    GENDER_CHOICES = (
        ("M", "Male"),
        ("F", "Female"),
        ("O" , "Others"),
        ("X", "No answer")
    )
    profile = models.ForeignKey(Profile, on_delete = models.CASCADE, blank = True)

    name =  models.CharField(max_length = 40)
    picture = models.ImageField(upload_to='childprofile_pics/', blank=True, null=True)
    gender = models.CharField(max_length = 1, choices = GENDER_CHOICES)
    dob = models.DateField()
    height = models.DecimalField(max_digits=5, decimal_places=2)
    weight = models.DecimalField(max_digits=5, decimal_places=2)
    bloodtype = models.CharField(max_length = 5)
    address = models.TextField()
    ismalnourished = models.BooleanField(default = False)
    allergies = models.TextField(blank = True,  null = True)

    def __str__(self) -> str:
        return self.name

class DietaryRestriction(models.Model):
    name = models.CharField(max_length = 20)
    description = models.TextField()

    profile = models.ForeignKey(Profile, blank = True, null = True, on_delete = models.CASCADE)
    childprofile = models.ForeignKey(ChildProfile, blank = True, null = True, on_delete = models.CASCADE)

    def __str__(self) -> str:
        return self.name

class MedicalRecord(models.Model):

    profile = models.ForeignKey(Profile, blank = True, null = True, on_delete = models.CASCADE)
    childprofile = models.ForeignKey(ChildProfile, blank = True, null = True, on_delete = models.CASCADE)

    age = models.IntegerField()
    height = models.DecimalField(max_digits=5, decimal_places=2)
    weight = models.DecimalField(max_digits=5, decimal_places=2)
    health_status = models.CharField(max_length = 20, blank = True)
    date = models.DateField(default=date.today)

    def __str__(self) -> str:
        return "medicalof_"+ str(self.date)
    

class Medication(models.Model):

    profile = models.ForeignKey(Profile, on_delete = models.CASCADE, null = True, blank = True)
    childprofile = models.ForeignKey(ChildProfile, blank = True, null = True, on_delete = models.CASCADE)

    name = models.CharField(max_length = 30)
    dosage = models.CharField(max_length = 50)
    frequency = models.IntegerField()
    intake_times = models.CharField(max_length = 255)

    def __str__(self) -> str:
        return self.name

class MedicationLog(models.Model):
    medication = models.ForeignKey(Medication, on_delete = models.CASCADE)
    intake_time = models.DateTimeField(default = datetime.now)
    is_taken = models.BooleanField(default = False)

    def __str__(self):
        return f"{self.medication.name} - {self.intake_time}"
    
class FollowUps(models.Model):
    profile = models.ForeignKey(Profile, on_delete = models.CASCADE, null = True, blank = True)
    childprofile = models.ForeignKey(ChildProfile, blank = True, null = True, on_delete = models.CASCADE)

    date = models.DateTimeField()
    location = models.TextField()

    def __str__(self) -> str:
        return f"followup_{self.childprofile.name}"