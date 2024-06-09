import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart' as shimmer_animation;

import '../colors.dart';
import '../dimens.dart';

class Shimmer extends StatelessWidget {
  final Widget child;
  final bool enabled;
  final Color baseColor;
  final Color highlightColor;
  final BorderRadius? borderRadius;

  const Shimmer({
    super.key,
    required this.child,
    this.enabled = true,
    this.baseColor = Colors.transparent,
    this.highlightColor = ColorSet.headline,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return enabled
        ? ClipRRect(
            borderRadius: borderRadius ??
                BorderRadius.circular(
                  Dimens.borderRadius,
                ),
            child: shimmer_animation.Shimmer(
              color: highlightColor,
              child: IgnorePointer(
                child: Container(
                  color: baseColor,
                  child: Opacity(
                    opacity: enabled ? 0.0 : 1.0,
                    child: child,
                  ),
                ),
              ),
            ),
          )
        : child;
  }
}
