import 'package:flutter/material.dart';
import 'package:pick_n_pay_user/features/signin/signin_screen.dart';
import 'package:pick_n_pay_user/features/signup/signup_screen.dart';
import 'package:pick_n_pay_user/theme/app_theme.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/vegetables.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(
                  0.5), // Adjust opacity (0.0 - fully transparent, 1.0 - fully opaque)
              BlendMode.darken, // Darken the image
            ),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'PICK N PAY',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Text(
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  '''Lorem Ipsum is simply dummy text of the printing and typesetting industry.  ''',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.normal, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConformationButton(
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SigninScreen(),
                            ));
                      },
                      color: secondaryColor,
                      title: '  Log in  ',
                    ),
                    const SizedBox(width: 20),
                    ConformationButton(
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ));
                      },
                      color: primaryColor,
                      title: 'Register',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ConformationButton extends StatelessWidget {
  const ConformationButton({
    super.key,
    this.ontap,
    required this.color,
    required this.title,
  });
  final Function()? ontap;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Material(
        color: color,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 12),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
