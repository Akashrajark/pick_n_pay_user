import 'package:flutter/material.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_button.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_text_formfield.dart';
import 'package:pick_n_pay_user/features/signin/signin_screen.dart';
import 'package:pick_n_pay_user/features/signup/signup_second_screen.dart';
import 'package:pick_n_pay_user/theme/app_theme.dart';
import 'package:pick_n_pay_user/util/value_validator.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment(1.4, -1),
            child: Image.asset(
              "assets/images/broccoli.png",
              width: 200,
              height: 200,
            ),
          ),
          Align(
            alignment: Alignment(-1.4, 1.2),
            child: Image.asset(
              "assets/images/capsicum.png",
              width: 250,
              height: 250,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Sign Up",
                      textAlign: TextAlign.left, // Center title
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    SizedBox(height: 20),

                    Text("Email"),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                        labelText: 'Enter email',
                        controller: _emailController,
                        validator: emailValidator),
                    SizedBox(height: 10),

                    // Password Field
                    Text("Password"),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                        labelText: 'Enter password',
                        controller: _passwordController,
                        suffixIconData: Icons.visibility_off,
                        validator: passwordValidator),
                    SizedBox(height: 10),

                    // Password Field
                    Text("Confirm Password"),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                        labelText: 'Enter confirm password',
                        suffixIconData: Icons.visibility_off,
                        controller: _confirmPasswordController,
                        validator: passwordValidator),
                    SizedBox(height: 22),

                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SigninScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Text(
                        "Already have Account! Signin?",
                        textAlign: TextAlign.right, // Center title
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.normal, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 35),

                    // Sign In Button Centered
                    CustomButton(
                      inverse: true,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupSecondScreen(),
                            ));
                      },
                      label: 'Next',
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
