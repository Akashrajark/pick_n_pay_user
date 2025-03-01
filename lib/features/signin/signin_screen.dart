import 'package:flutter/material.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_button.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_text_formfield.dart';
import 'package:pick_n_pay_user/features/signup/signup_screen.dart';
import 'package:pick_n_pay_user/theme/app_theme.dart';
import 'package:pick_n_pay_user/util/value_validator.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                      "Sign In",
                      textAlign: TextAlign.left, // Center title
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    SizedBox(height: 20),

                    // Email Field
                    Text("Email"),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                        labelText: 'Enter Email',
                        controller: _emailController,
                        validator: emailValidator),
                    SizedBox(height: 10),

                    Text("Password"),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                        suffixIconData: Icons.visibility_off,
                        labelText: 'Enter Password',
                        controller: _passwordController,
                        validator: passwordValidator),
                    SizedBox(height: 22),

                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Text(
                        "Don't have an Account! Signup?",
                        textAlign: TextAlign.right, // Center title
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.normal, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 35),

                    // Sign In Button Centered
                    CustomButton(
                      inverse: true,
                      onPressed: () {},
                      label: 'Signin',
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
