import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

class OnScreenOptionItemCard extends StatefulWidget {
  const OnScreenOptionItemCard({
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    this.animationDuration = const Duration(milliseconds: 1500),
    super.key,
  });

  final String iconPath;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  final Duration animationDuration;

  @override
  State<OnScreenOptionItemCard> createState() => _OnScreenOptionItemCardState();
}

class _OnScreenOptionItemCardState extends State<OnScreenOptionItemCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (final BuildContext context, final Widget? child) {
        return SlideTransition(position: _slideAnimation, child: child);
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: .circular(20)),
        color: context.appColors.cardBackground,
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: .circular(20),
          child: Padding(
            padding: const .symmetric(horizontal: 20, vertical: 26),
            child: Row(
              spacing: 16,
              crossAxisAlignment: .start,
              children: <Widget>[
                Container(
                  width: 56,
                  height: 56,
                  padding: const .all(12),
                  decoration: BoxDecoration(
                    color: context.appColors.primaryDefault,
                    borderRadius: .circular(12),
                  ),
                  child: SvgPicture.asset(
                    widget.iconPath,
                    colorFilter: .mode(context.appColors.surfaceL1, .srcIn),
                  ),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const .symmetric(vertical: 4),
                    children: <Widget>[
                      Text(
                        widget.title,
                        style: AppTextStyles.airbnbCerealW600S18Lh24Ls0
                            .copyWith(color: context.appColors.textPrimary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.subtitle,
                        style: AppTextStyles.interW400S14Lh20Ls0_2.copyWith(
                          color: context.appColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
