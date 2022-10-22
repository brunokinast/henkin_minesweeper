import 'package:henkin_minesweeper/models/field.dart';
import 'package:flutter/material.dart';

class FieldWidget extends StatelessWidget {
  final Field field;
  final void Function(Field) onTap;
  final void Function(Field) onFlag;

  const FieldWidget({
    required this.field,
    required this.onTap,
    required this.onFlag,
  });

  String get image {
    if (field.blown) return 'assets/images/blown.jpeg';
    if (field.opened && field.mined) return 'assets/images/openAndMined.jpeg';
    if (field.opened)
      return 'assets/images/open_${field.neighborhoodMineCount}.jpeg';
    if (field.flagged) return 'assets/images/flagged.jpeg';
    return 'assets/images/notOpen.jpeg';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(field),
      onLongPress: () => onFlag(field),
      child: Image.asset(image),
    );
  }
}
