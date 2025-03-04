import 'package:flutter/material.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_alert_dialog.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_button.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_text_formfield.dart';
import 'package:pick_n_pay_user/features/signin/signin_screen.dart';
import 'package:pick_n_pay_user/features/signup/signup_second_screen.dart';
import 'package:pick_n_pay_user/theme/app_theme.dart';
import 'package:pick_n_pay_user/util/value_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_up_bloc/sign_up_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocProvider(
        create: (context) => SignUpBloc(),
        child: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failure',
                  description: state.message,
                  primaryButton: 'Try Again',
                  onPrimaryPressed: () {
                    Navigator.pop(context);
                  },
                ),
              );
            } else if (state is SignUpSuccessState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SignupSecondScreen(
                    signupDetails: {
                      'email': _emailController.text.trim(),
                      'password': _passwordController.text.trim(),
                    },
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return Stack(
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
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                          ),
                          SizedBox(height: 20),
                          Text("Email"),
                          SizedBox(height: 8),
                          CustomTextFormField(
                            labelText: 'Enter email',
                            controller: _emailController,
                            validator: emailValidator,
                            isLoading: state is SignUpLoadingState,
                          ),
                          SizedBox(height: 10),
                          Text("Password"),
                          SizedBox(height: 8),
                          TextFormField(
                              enabled: state is! SignUpLoadingState,
                              controller: _passwordController,
                              obscureText: isObscure,
                              validator: passwordValidator,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      isObscure = !isObscure;
                                      setState(() {});
                                    },
                                    icon: Icon(isObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility)),
                                border: const OutlineInputBorder(),
                                hintText: 'Password',
                              )),
                          SizedBox(height: 10),
                          Text("Confirm Password"),
                          SizedBox(height: 8),
                          TextFormField(
                              enabled: state is! SignUpLoadingState,
                              controller: _confirmPasswordController,
                              obscureText: isObscure,
                              validator: (value) => confirmPasswordValidator(
                                  value, _passwordController.text.trim()),
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      isObscure = !isObscure;
                                      setState(() {});
                                    },
                                    icon: Icon(isObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility)),
                                border: const OutlineInputBorder(),
                                hintText: 'Password',
                              )),
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
                              textAlign: TextAlign.right,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 35),
                          CustomButton(
                            inverse: true,
                            isLoading: state is SignUpLoadingState,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<SignUpBloc>(context).add(
                                  SignUpUserEvent(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  ),
                                );
                              }
                            },
                            label: 'Next',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
