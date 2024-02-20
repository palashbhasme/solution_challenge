
def nutritional_status(age_year, weight_kg, height_cm):
    age_months = age_year * 12
    bmi = weight_kg / ((height_cm / 100) ** 2)

    if age_months < 60:  # For children under 5 years old
        if bmi < 16:
            return 'Severe acute malnutrition (SAM)'
        elif bmi < 17:
            return 'Moderate acute malnutrition (MAM)'
        else:
            return 'Normal'
    else:  # For children 5 years and older
        if bmi < 16:
            return 'Severe acute malnutrition (SAM)'
        elif bmi < 17:
            return 'Moderate acute malnutrition (MAM)'
        elif bmi < 18.5:
            return 'Underweight'
        else:
            return 'Normal'