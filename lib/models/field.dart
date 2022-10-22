import 'package:henkin_minesweeper/models/exceptions.dart';

class Field {
  final int row;
  final int column;

  Field({
    required this.column,
    required this.row,
  });

  List<Field> neighbors = [];
  bool _opened = false;
  bool _blown = false;
  bool _mined = false;
  bool _flagged = false;
  bool get opened => _opened;
  bool get blown => _blown;
  bool get mined => _mined;
  void mine() => _mined = true;
  bool get flagged => _flagged;

  void restart() {
    _opened = false;
    _blown = false;
    _mined = false;
    _flagged = false;
  }

  void open() {
    if (!_opened) {
      _opened = true;
      _blown = _mined;
      if (_blown) throw ExplosionException();
      if (isSafeNeighborhood) for (var n in neighbors) n.open();
    }
  }

  void reveal() {
    if (_mined) _opened = true;
  }

  void toggleFlagged() {
    _flagged = !_flagged;
  }

  void addNeighbor(Field field) {
    if (isNeighbor(field)) neighbors.add(field);
  }

  bool isNeighbor(Field field) {
    int rowDelta = (row - field.row).abs();
    int columnDelta = (column - field.column).abs();
    return (rowDelta + columnDelta != 0) && (rowDelta <= 1 && columnDelta <= 1);
  }

  bool get isSafeNeighborhood => neighbors.every((n) => !n.mined);

  int get neighborhoodMineCount => neighbors.where((n) => n.mined).length;

  bool get solved => (_opened && !_mined) || (_flagged && _mined);
}
