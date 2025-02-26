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
      TextEditingController(text: 'Mandan');
  final TextEditingController _emailController =
      TextEditingController(text: 'mandan@pottan.com');
  final TextEditingController _phoneController =
      TextEditingController(text: '1165654546');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          children: [
            // Back Button
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            const SizedBox(height: 20),

            // Name
            CustomTextFormField(
                labelText: 'Name',
                controller: _usernameController,
                validator: notEmptyValidator),

            const SizedBox(height: 16),

            // Email
            CustomTextFormField(
                labelText: 'Email',
                controller: _emailController,
                validator: emailValidator),

            const SizedBox(height: 16),

            // Phone
            CustomTextFormField(
                labelText: 'Phone',
                controller: _phoneController,
                validator: phoneNumberValidator),

            const SizedBox(height: 30),

            CustomButton(
              inverse: true,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => ChangePasswordDialog(),
                );
              },
              label: 'Change Password',
            ),

            const SizedBox(height: 16),

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
          ],
        ),
      ),
    );
  }
}
