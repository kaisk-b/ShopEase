import 'package:flutter/material.dart';

class SpotlightNavBar extends StatelessWidget {
  const SpotlightNavBar({
    required this.selectedIndex,
    required this.onItemSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  static const List<IconData> _icons = [
    Icons.home_rounded,
    Icons.category_rounded,
    Icons.shopping_bag_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / _icons.length;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 74,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A4A4A),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 20,
                        offset: Offset(0, 10),
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                left: selectedIndex * itemWidth + itemWidth * 0.2,
                top: 0,
                width: itemWidth * 0.6,
                height: 12,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                left: selectedIndex * itemWidth + itemWidth * 0.18,
                top: 8,
                width: itemWidth * 0.64,
                height: 64,
                child: IgnorePointer(
                  child: ClipPath(
                    clipper: LightRayClipper(),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withValues(alpha: 0.85),
                            Colors.white.withValues(alpha: 0.25),
                            Colors.white.withValues(alpha: 0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                top: 18,
                child: Row(
                  children: [
                    for (int index = 0; index < _icons.length; index++)
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(40),
                          onTap: () => onItemSelected(index),
                          child: Center(
                            child: AnimatedScale(
                              duration: const Duration(milliseconds: 250),
                              scale: selectedIndex == index ? 1.15 : 1,
                              child: Icon(
                                _icons[index],
                                size: 32,
                                color: selectedIndex == index
                                    ? Colors.white
                                    : Colors.black.withValues(alpha: 0.55),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class LightRayClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(size.width * 0.2, 0)
      ..lineTo(size.width * 0.8, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
