import 'package:flutter/material.dart';

class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(label),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 18),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(child: Text('A')),
            SizedBox(width: 18),
            CircleAvatar(child: Text('f')),
            SizedBox(width: 18),
            CircleAvatar(child: Text('G')),
          ],
        ),
      ],
    );
  }
}
