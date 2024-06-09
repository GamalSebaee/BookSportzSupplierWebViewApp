import 'package:flutter/material.dart';

import '../dimens.dart';

class SpaceVertical extends StatelessWidget {
  final double space;

  const SpaceVertical({
    super.key,
    this.space = Dimens.standardSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: space,
    );
  }
}

class SpaceHorizontal extends StatelessWidget {
  final double space;

  const SpaceHorizontal({
    super.key,
    this.space = Dimens.standardSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: space,
    );
  }
}
