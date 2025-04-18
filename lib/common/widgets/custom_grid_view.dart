import 'package:flutter/material.dart';

Widget customGridView({
  required List<Widget> children,
  ScrollPhysics? physics,
}) {
  return GridView.count(
    crossAxisCount: 2,
    childAspectRatio: 2 / 1,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
    shrinkWrap: true,
    physics: physics,
    children: children,
  );
}
