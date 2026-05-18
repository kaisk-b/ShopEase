import 'package:flutter/material.dart';

import '../../../../app/app.dart';
import '../widgets/auth_card.dart';
import '../widgets/social_login_row.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthCard(
      title: 'Login',
      children: [
        const TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email address',
            hintText: 'shopper@shopease.test',
          ),
        ),
        const SizedBox(height: 14),
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'shop1234',
            suffixIcon: Icon(Icons.visibility_off),
          ),
        ),
        const SizedBox(height: 14),
        const _SampleAccountPanel(),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.home,
            (_) => false,
          ),
          child: const Text('Login'),
        ),
        const SizedBox(height: 20),
        const SocialLoginRow(label: 'or login with'),
      ],
    );
  }
}

class _SampleAccountPanel extends StatelessWidget {
  const _SampleAccountPanel();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.account_circle_outlined),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Sample account: shopper@shopease.test / shop1234',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
