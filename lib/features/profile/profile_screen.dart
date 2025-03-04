import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pick_n_pay_user/features/profile/edit_profile_screen.dart';
import 'package:pick_n_pay_user/util/format_function.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../common_widgets.dart/change_password.dart';
import '../../common_widgets.dart/custom_alert_dialog.dart';
import '../../common_widgets.dart/custom_button.dart';
import '../../util/check_login.dart';
import '../signin/signin_screen.dart';
import 'profile_bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileBloc _profileBloc = ProfileBloc();
  Map _profile = {};

  @override
  void initState() {
    getProfile();
    checkLogin(context);
    super.initState();
  }

  void getProfile() {
    _profileBloc.add(GetAllProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _profileBloc,
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                description: state.message,
                primaryButton: 'Try Again',
                onPrimaryPressed: () {
                  getProfile();
                  Navigator.pop(context);
                },
              ),
            );
          } else if (state is ProfileGetSuccessState) {
            _profile = state.profile;
            setState(() {});
          } else if (state is ProfileSuccessState) {
            getProfile();
          }
        },
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (_profile['photo'] != null)
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(_profile['photo']),
                        ),
                      SizedBox(height: 16),
                      Text(
                        formatValue(_profile['name']),
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                      ),
                      SizedBox(height: 8),
                      Text(
                        formatValue(_profile['email']),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(height: 8),
                      Text(
                        formatValue(_profile['phone']),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(height: 16),
                      CustomButton(
                        inverse: true,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: _profileBloc,
                                child: EditProfileScreen(profile: _profile),
                              ),
                            ),
                          ).then((value) {
                            getProfile();
                          });
                        },
                        label: 'Edit Profile',
                      ),
                      SizedBox(height: 16),
                      CustomButton(
                        inverse: true,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const ChangePasswordDialog(),
                          );
                        },
                        label: 'Change Password',
                      ),
                      SizedBox(height: 16),
                      CustomButton(
                        inverse: true,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => CustomAlertDialog(
                              title: "SIGN OUT",
                              content: const Text(
                                "Are you sure you want to Sign Out? Clicking 'Sign Out' will end your current session and require you to sign in again to access your account.",
                              ),
                              primaryButton: "SIGN OUT",
                              onPrimaryPressed: () {
                                Supabase.instance.client.auth.signOut();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SigninScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                            ),
                          );
                        },
                        label: 'Sign Out',
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
