from firebase_admin import auth


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
        

def Firebase_validation(id_token):
    """
    This function receives id token sent by Firebase and
    validate the id token then check if the user exist on
    Firebase or not if exist it returns True else False
    """
    try:
        decoded_token = auth.verify_id_token(id_token)
        uid = decoded_token['uid']
        provider = decoded_token['firebase']['sign_in_provider']
        image = None
        name = None
        if "name" in decoded_token:
            name = decoded_token['name']
        if "picture" in decoded_token:
            image = decoded_token['picture']
        try:
            user = auth.get_user(uid)
            email = user.email
            if user:
                return {
                    "status": True,
                    "uid": uid,
                    "email": email,
                    "name": name,
                    "provider": provider,
                    "image": image
                }
            else:
                return False
        except auth.UserNotFoundError:
            print("user not exist")
    except auth.ExpiredIdTokenError():
        print("Token expired")