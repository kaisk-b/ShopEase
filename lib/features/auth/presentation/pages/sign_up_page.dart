import 'package:flutter/material.dart';

import '../../../../app/app.dart';
import '../widgets/auth_card.dart';
import '../widgets/social_login_row.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _acceptedTerms = false;

  @override
  Widget build(BuildContext context) {
    return AuthCard(
      title: 'Sign Up',
      children: [
        const TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(labelText: 'Email address'),
        ),
        const SizedBox(height: 14),
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            suffixIcon: Icon(Icons.visibility_off),
          ),
        ),
        const SizedBox(height: 14),
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Confirm password',
            suffixIcon: Icon(Icons.visibility_off),
          ),
        ),
        const SizedBox(height: 16),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          value: _acceptedTerms,
          onChanged: (value) {
            setState(() {
              _acceptedTerms = value ?? false;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
          title: const Text(
            'I accept terms and conditions',
            style: TextStyle(fontSize: 13),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _acceptedTerms
              ? () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.home,
                  (_) => false,
                )
              : null,
          child: const Text('Create Account'),
        ),
        const SizedBox(height: 12),
        Center(
          child: TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.login),
            child: const Text('Already have an account? Login'),
          ),
        ),
        const SizedBox(height: 20),
        const SocialLoginRow(label: 'or sign up with'),
      ],
    );
  }
}
