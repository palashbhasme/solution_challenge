import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/global_variables.dart';
import '../widgets/custom_text_form_field.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String? firstName;
  String? email;
  String? password;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 100,
        title: Image(
          image: AssetImage('assets/images/logo.png'),
          color: GlobalVariables.secondary_color,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.1,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  'Hi there!',
                  style: TextStyle(
                    color: GlobalVariables.secondary_color,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  'Let\'s quickly get your profile created',
                  style: TextStyle(
                    color: GlobalVariables.secondary_color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.15,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      labelText: 'First name',
                      obscureText: false,
                      prefixIcon: const Icon(Icons.person),
                      onSaved: (val) {
                        setState(() {
                          firstName = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFormField(
                      labelText: 'Email',
                      obscureText: false,
                      prefixIcon: const Icon(Icons.email),
                      onSaved: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      validator: (val) {
                        // if (!EmailValidator.validate(val)) {
                        //   return 'Please enter a valid email';
                        // }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFormField(
                      labelText: 'Password',
                      obscureText: true,
                      prefixIcon: const Icon(Icons.lock),
                      onSaved: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty || val.length < 8) {
                          return 'The password should contain 8 or more characters';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalVariables.secondary_color,
                      elevation: 0,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () async {
                    // if (_formKey.currentState!.validate()) {
                    //   _formKey.currentState!.save();
                    //   final username = await AuthServices.signUp(
                    //       firstName!, email!, password!);
                    //   if (username != null) {
                    //     Navigator.pushReplacement(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => HomeScreen(
                    //           // username: username,
                    //           // prefs: widget.prefs,
                    //         ),
                    //       ),
                    //     );
                    //   }
                    // }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Create profile',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(
                            // prefs: widget.prefs,
                            ),
                      ),
                    );
                  },
                  child: const Text(
                    'Already have an account? Sign in',
                    style: TextStyle(
                      fontSize: 16,
                      color: GlobalVariables.secondary_color,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
