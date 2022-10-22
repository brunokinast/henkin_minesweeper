import 'dart:math';
import 'package:henkin_minesweeper/models/exceptions.dart';
import 'package:henkin_minesweeper/models/field.dart';

class Board {
  final int rows;
  final int columns;
  final int bombs;
  final List<Field> fields = [];

  Board({
    required this.rows,
    required this.columns,
    required this.bombs,
  }) {
    _populateFields();
    _setNeighbors();
    _shuffleBombs();
  }

  void restart() {
    for (var f in fields) f.restart();
    _shuffleBombs();
  }

  void reveal() {
    for (var f in fields) f.reveal();
  }

  void _populateFields() {
    for (int i = 0; i < rows; i++)
      for (int j = 0; j < columns; j++) fields.add(Field(row: i, column: j));
  }

  void _setNeighbors() {
    for (var f in fields) for (var n in fields) f.addNeighbor(n);
  }

  void _shuffleBombs() {
    if (bombs > rows * columns) throw TooManyBombsException();
    for (int i = 0; i < bombs;) {
      int x = Random().nextInt(fields.length);
      if (!fields[x].mined) {
        fields[x].mine();
        i++;
      }
    }
  }

  bool get isSolved => fields.every((f) => f.solved);
}
