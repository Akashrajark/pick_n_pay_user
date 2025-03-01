import 'package:flutter/material.dart';
import 'package:pick_n_pay_user/common_widgets.dart/change_password.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_button.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_text_formfield.dart';
import 'package:pick_n_pay_user/util/value_validator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _usernameController =
      TextEditingController(text: 'Joseph');
  final TextEditingController _emailController =
      TextEditingController(text: 'Joseph@gmail.com');
  final TextEditingController _phoneController =
      TextEditingController(text: '9055268583');
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Edit Button
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(_isEditing ? Icons.check : Icons.edit),
                onPressed: () {
                  setState(() {
                    _isEditing = !_isEditing;
                  });
                },
              ),
            ),

            const SizedBox(height: 20),

            // Profile Picture
            CircleAvatar(
              radius: 50,
              backgroundColor: theme.primaryColor.withOpacity(0.1),
              child: Text(
                _usernameController.text[0].toUpperCase(),
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Name
            CustomTextFormField(
              labelText: 'Name',
              controller: _usernameController,
              validator: notEmptyValidator,
              prefixIconData: Icons.person,
            ),

            const SizedBox(height: 16),

            // Email
            CustomTextFormField(
              labelText: 'Email',
              controller: _emailController,
              validator: emailValidator,
              prefixIconData: Icons.email,
            ),

            const SizedBox(height: 16),

            // Phone
            CustomTextFormField(
              labelText: 'Phone',
              controller: _phoneController,
              validator: phoneNumberValidator,
              prefixIconData: Icons.phone,
            ),

            const SizedBox(height: 30),

            // Change Password Button
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

            const SizedBox(height: 20),

            // Logout Button
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: 8),
                  Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Delete Account Option
            TextButton(
              onPressed: () {},
              child: const Text(
                'Delete Account',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
