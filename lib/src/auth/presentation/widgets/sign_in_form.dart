import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/common/widgets/i_fields.dart';
import '../../../../core/res/colours.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    required this.usernameController,
    required this.passwordController,
    required this.signInKey,
    super.key,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> signInKey;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.signInKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Username',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colours.primaryColour),
            ),
            const SizedBox(height: 10),
            IFields(
              controller: widget.usernameController,
              hintText: 'Username',
              keyboardType: TextInputType.name,
              overrideValidator: true,
            ),
            const SizedBox(height: 25),
            const Text(
              'Password',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colours.primaryColour),
            ),
            const SizedBox(height: 10),
            IFields(
              controller: widget.passwordController,
              hintText: 'Password',
              obscureText: obscurePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
                icon: Icon(
                  obscurePassword ? IconlyBold.show : IconlyBold.hide,
                  color: Colours.primaryColour,
                ),
              ),
            ),
          ],
        ));
  }
}
