import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_alert_dialog.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_button.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_text_formfield.dart';
import 'package:pick_n_pay_user/features/home/home.dart';
import 'package:pick_n_pay_user/theme/app_theme.dart';
import 'package:pick_n_pay_user/util/value_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_widgets.dart/custom_image_picker_button.dart';
import 'sign_up_bloc/sign_up_bloc.dart';

class SignupSecondScreen extends StatefulWidget {
  final Map<String, String> signupDetails;
  const SignupSecondScreen({super.key, required this.signupDetails});

  @override
  State<SignupSecondScreen> createState() => _SignupSecondScreenState();
}

class _SignupSecondScreenState extends State<SignupSecondScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  File? profilePhoto;

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
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
                (route) => false,
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
                            "Verify...",
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Profile photo',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CustomImagePickerButton(
                              showRequiredError: true,
                              onPick: (file) {
                                profilePhoto = file;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Text("Username"),
                          SizedBox(height: 8),
                          CustomTextFormField(
                            labelText: 'Enter username',
                            controller: _usernameController,
                            validator: notEmptyValidator,
                            isLoading: state is SignUpLoadingState,
                          ),
                          SizedBox(height: 10),
                          Text("Phone"),
                          SizedBox(height: 8),
                          CustomTextFormField(
                            labelText: 'Enter phone no.',
                            controller: _phoneController,
                            validator: phoneNumberValidator,
                            isLoading: state is SignUpLoadingState,
                          ),
                          SizedBox(height: 35),
                          CustomButton(
                            inverse: true,
                            isLoading: state is SignUpLoadingState,
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  profilePhoto != null) {
                                Map<String, dynamic> details = {
                                  'email': widget.signupDetails['email'],
                                  'name': _usernameController.text.trim(),
                                  'phone': _phoneController.text.trim(),
                                };
                                if (profilePhoto != null) {
                                  details['photo_file'] = profilePhoto!;
                                  details['photo_name'] = profilePhoto!.path;
                                }
                                BlocProvider.of<SignUpBloc>(context).add(
                                  InsertUserDataEvent(
                                    userDetails: details,
                                  ),
                                );
                              }
                            },
                            label: 'Signup',
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
