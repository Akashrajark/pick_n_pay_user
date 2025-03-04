import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_alert_dialog.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_button.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_text_formfield.dart';
import 'package:pick_n_pay_user/features/home/home.dart';
import 'package:pick_n_pay_user/features/signin/signin_bloc/signin_bloc.dart';
import 'package:pick_n_pay_user/features/signup/signup_screen.dart';
import 'package:pick_n_pay_user/theme/app_theme.dart';
import 'package:pick_n_pay_user/util/value_validator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isObscure = true;

  @override
  void initState() {
    Future.delayed(
        const Duration(
          milliseconds: 100,
        ), () {
      User? currentUser = Supabase.instance.client.auth.currentUser;
      if (currentUser != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocProvider(
        create: (context) => SigninBloc(),
        child: BlocConsumer<SigninBloc, SigninState>(
          listener: (context, state) {
            if (state is SigninSuccessState) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Home()),
                (route) => false,
              );
            } else if (state is SigninFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failed',
                  description: state.message,
                  primaryButton: 'Ok',
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
                            "Sign In",
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
                              labelText: 'Enter Email',
                              controller: _emailController,
                              validator: emailValidator,
                              isLoading: state is SigninLoadingState),
                          SizedBox(height: 10),
                          Text("Password"),
                          SizedBox(height: 8),
                          TextFormField(
                              enabled: state is! SigninLoadingState,
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
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<SigninBloc>(context).add(
                                  SigninEvent(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  ),
                                );
                              }
                            },
                            label: 'Signin',
                            isLoading: state is SigninLoadingState,
                          )
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
