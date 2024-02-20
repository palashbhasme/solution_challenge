from django.contrib import admin

from .models import *

# Register your models here.

admin.site.register(ChildProfile)
admin.site.register(Profile)
admin.site.register(MedicalRecord)
admin.site.register(Medication)
admin.site.register(DietaryRestriction)
admin.site.register(FollowUps)
