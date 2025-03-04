import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_alert_dialog.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_button.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_text_formfield.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_image_picker_button.dart';
import 'package:pick_n_pay_user/util/value_validator.dart';
import 'profile_bloc/profile_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  final Map? profile;
  const EditProfileScreen({super.key, this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  File? profilePhoto;

  @override
  void initState() {
    if (widget.profile != null) {
      _nameController.text = widget.profile!['name'];
      _phoneController.text = widget.profile!['phone'];
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: BlocProvider(
        create: (context) => ProfileBloc(),
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
                    Navigator.pop(context);
                  },
                ),
              );
            } else if (state is ProfileSuccessState) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomImagePickerButton(
                      showRequiredError: false,
                      selectedImage: widget.profile?['photo'],
                      onPick: (file) {
                        profilePhoto = file;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 16),
                    CustomTextFormField(
                      labelText: 'Name',
                      controller: _nameController,
                      validator: notEmptyValidator,
                      isLoading: state is ProfileLoadingState,
                    ),
                    SizedBox(height: 16),
                    CustomTextFormField(
                      labelText: 'Phone',
                      controller: _phoneController,
                      validator: phoneNumberValidator,
                      isLoading: state is ProfileLoadingState,
                    ),
                    SizedBox(height: 16),
                    CustomButton(
                      inverse: true,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> updatedProfile = {
                            'name': _nameController.text.trim(),
                            'phone': _phoneController.text.trim(),
                          };
                          if (profilePhoto != null) {
                            updatedProfile['photo_file'] = profilePhoto!;
                            updatedProfile['photo_name'] = profilePhoto!.path;
                          }
                          BlocProvider.of<ProfileBloc>(context).add(
                            EditProfileEvent(
                              profile: updatedProfile,
                              profileId: widget.profile!['id'],
                            ),
                          );
                        }
                      },
                      label: 'Save',
                      isLoading: state is ProfileLoadingState,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
