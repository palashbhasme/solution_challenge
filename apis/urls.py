from django.urls import include, path

from .views import *

urlpatterns = [
    path("child/list/", ChildListAPIView.as_view()), # To GET a list of all the children
    path("child/detail/<int:id>/", ChildDetailAPIView.as_view()), # To GET details of a child

    path('dietary-restrictions/', DietaryRestrictionsAPIView.as_view(), name='dietary_restrictions'), # To GET and POST a dietary restriction
    path('dietary-restrictions/<int:child_id>/', DietaryRestrictionsAPIView.as_view(), name='dietary_restrictions_with_child_profile'), # To GET dietary restriction if it's of child

    path('medication/', MedicationAPIView.as_view(), name='dietary_restrictions'), # To GET and POST a medication
    path('medication/<int:child_id>/', MedicationAPIView.as_view(), name='dietary_restrictions_with_child_profile'), # To GET medication if it's of child

    path("medical/list/<str:profile_type>/<int:id>/", MedicalRecordListAPIView.as_view()), # To GET list of the medical records of the user
    path("medical/", MedicalRecordAPIView.as_view()), # To POST a new medical record
    path("medical/<int:record_id>/", MedicalRecordAPIView.as_view()), # To GET details of a medical record
]