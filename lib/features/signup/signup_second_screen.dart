import 'package:flutter/material.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_button.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_text_formfield.dart';
import 'package:pick_n_pay_user/theme/app_theme.dart';
import 'package:pick_n_pay_user/util/value_validator.dart';

class SignupSecondScreen extends StatefulWidget {
  const SignupSecondScreen({super.key});

  @override
  State<SignupSecondScreen> createState() => _SignupSecondScreenState();
}

class _SignupSecondScreenState extends State<SignupSecondScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
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
                      "Verify...",
                      textAlign: TextAlign.left, // Center title
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    SizedBox(height: 20),

                    Text("Username"),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                        labelText: 'Enter username',
                        controller: _usernameController,
                        validator: notEmptyValidator),
                    SizedBox(height: 10),

                    Text("Phone"),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                        labelText: 'Enter phone no.',
                        controller: _phoneController,
                        validator: emailValidator),

                    SizedBox(height: 35),

                    // Sign In Button Centered
                    CustomButton(
                      inverse: true,
                      onPressed: () {},
                      label: 'Signup',
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
