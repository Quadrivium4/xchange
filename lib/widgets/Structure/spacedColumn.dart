import 'package:flutter/material.dart';

class SpacedColumn extends StatelessWidget {
  final List<Widget> children;
  final double? spacing;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  const SpacedColumn({super.key, required this.children, this.spacing, this.crossAxisAlignment, this.mainAxisAlignment});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: spacingFunction(children),
    );
  }

  List<Widget> spacingFunction (List<Widget> children) {
    return List.generate(
        children.isNotEmpty ? children.length * 2 - 1 : 0,
        (index) => index.isEven
            ? children[(index/2).toInt()]
            : SizedBox(height: spacing ?? 8,),
    );
  }

}
