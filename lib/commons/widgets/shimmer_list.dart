import 'package:flutter/cupertino.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../dimens.dart';
import 'view-space.dart';

class ShimmerList extends StatelessWidget {
  final double? itemHeight;

  const ShimmerList({super.key, this.itemHeight});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        vertical: Dimens.viewMargin / 2,
        horizontal: Dimens.homeHorizontalPadding,
      ),
      itemBuilder: (context, index) => Shimmer(
        child: SizedBox(
          width: double.infinity,
          height: itemHeight ?? 150,
        ),
      ),
      separatorBuilder: (context, index) => const SpaceVertical(
        space: Dimens.viewMargin / 2,
      ),
      itemCount: 5,
    );
  }
}
