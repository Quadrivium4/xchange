import 'package:flutter/material.dart';

class SpacedColumn extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  const SpacedColumn({super.key, required this.children, required this.spacing, this.crossAxisAlignment, this.mainAxisAlignment});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      children: spacingFunction(children),
    );
  }

  List<Widget> spacingFunction (List<Widget> children) {
    return List.generate(
        children.length * 2 - 1,
        (index) => index.isEven
            ? children[(index/2).toInt()]
            : SizedBox(height: spacing,),
    );
  }

}
