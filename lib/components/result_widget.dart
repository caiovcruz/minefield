import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool? won;
  final Function onRestart;

  const ResultWidget({
    Key? key,
    required this.won,
    required this.onRestart,
  }) : super(key: key);

  Color _getColor() {
    if (won == null) {
      return Colors.yellow;
    } else if (won!) {
      return Colors.green[500]!;
    } else {
      return Colors.red[500]!;
    }
  }

  IconData _getIcon() {
    if (won == null) {
      return Icons.sentiment_satisfied;
    } else if (won!) {
      return Icons.sentiment_very_satisfied;
    } else {
      return Icons.sentiment_very_dissatisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: _getColor(),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => onRestart(),
              icon: Icon(
                _getIcon(),
                color: Colors.black,
                size: 35,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
