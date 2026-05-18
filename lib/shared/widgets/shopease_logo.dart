import 'package:flutter/material.dart';

import '../../core/config/app_assets.dart';

class ShopEaseLogo extends StatelessWidget {
  const ShopEaseLogo({
    this.height = 40,
    this.showText = true,
    this.textColor,
    super.key,
  });

  final double height;
  final bool showText;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          AppAssets.logo,
          height: height,
          width: height,
          fit: BoxFit.contain,
        ),
        if (showText) ...[
          const SizedBox(width: 8),
          Text(
            'ShopEase',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ],
    );
  }
}
