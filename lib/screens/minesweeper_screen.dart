import 'package:henkin_minesweeper/models/board.dart';
import 'package:henkin_minesweeper/models/exceptions.dart';
import 'package:henkin_minesweeper/models/field.dart';
import 'package:henkin_minesweeper/widgets/board_widget.dart';
import 'package:henkin_minesweeper/widgets/face_appbar.dart';
import 'package:flutter/material.dart';

class MineSweeperScreen extends StatefulWidget {
  @override
  MineSweeperScreenState createState() => MineSweeperScreenState();
}

class MineSweeperScreenState extends State<MineSweeperScreen> {
  bool? _won;
  Board? _board;

  void _tap(Field field) {
    if (_won == null)
      setState(() {
        try {
          field.open();
          _didWon();
        } on ExplosionException {
          _board!.reveal();
          _won = false;
        }
      });
  }

  void _flag(Field field) {
    if (_won == null)
      setState(() {
        field.toggleFlagged();
        _didWon();
      });
  }

  void _didWon() {
    if (_board!.isSolved) _won = true;
  }

  void _restart() {
    setState(() {
      _won = null;
      _board!.restart();
    });
  }

  Board _getBoard(double width, double height) {
    if (_board == null) {
      int columns = 15;
      int rows = (height / (width / columns)).floor();
      _board = Board(
        columns: columns,
        rows: rows,
        bombs: 50,
      );
    }
    return _board!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrunoMinesweeper',
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey,
          appBar: FaceAppBar(
            won: _won,
            onRestart: _restart,
          ),
          body: LayoutBuilder(
            builder: (_, c) => BoardWidget(
              board: _getBoard(c.maxWidth, c.maxHeight),
              onTap: _tap,
              onFlag: _flag,
            ),
          ),
        ),
      ),
    );
  }
}
