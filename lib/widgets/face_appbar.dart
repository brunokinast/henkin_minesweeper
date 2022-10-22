import 'package:flutter/material.dart';

class FaceAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? won;
  final void Function() onRestart;

  const FaceAppBar({
    required this.won,
    required this.onRestart,
  });

  Color _getColor() {
    if (won == null) return Colors.yellow;
    if (won!) return Colors.green[300]!;
    return Colors.red[300]!;
  }

  IconData _getIcon() {
    if (won == null) return Icons.sentiment_neutral;
    if (won!) return Icons.sentiment_very_satisfied;
    return Icons.sentiment_very_dissatisfied;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.grey,
      child: CircleAvatar(
        backgroundColor: _getColor(),
        child: IconButton(
          padding: const EdgeInsets.all(0),
          icon: Icon(
            _getIcon(),
            color: Colors.black,
            size: 35,
          ),
          onPressed: onRestart,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
