import 'package:flutter/material.dart';

import '../../../../app/app.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.person_rounded, size: 64),
            const SizedBox(height: 16),
            Text(
              'Profile',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text('Signed in with sample account.'),
            const SizedBox(height: 6),
            Text(
              'shopper@shopease.test',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.welcome,
                (_) => false,
              ),
              icon: const Icon(Icons.logout_rounded),
              label: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
