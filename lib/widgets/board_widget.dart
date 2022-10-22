import 'package:henkin_minesweeper/models/board.dart';
import 'package:henkin_minesweeper/models/field.dart';
import 'package:henkin_minesweeper/widgets/field_widget.dart';
import 'package:flutter/material.dart';

class BoardWidget extends StatelessWidget {
  final Board board;
  final Function(Field) onTap;
  final Function(Field) onFlag;

  const BoardWidget({
    required this.board,
    required this.onTap,
    required this.onFlag,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: board.columns,
      children: board.fields
          .map((f) => FieldWidget(
                field: f,
                onTap: onTap,
                onFlag: onFlag,
              ))
          .toList(),
    );
  }
}
