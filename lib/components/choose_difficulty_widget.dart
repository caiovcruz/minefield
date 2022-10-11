import 'package:flutter/material.dart';

class ChooseDifficultyWidget extends StatelessWidget {
  final void Function(double) onChooseDifficulty;

  const ChooseDifficultyWidget({
    Key? key,
    required this.onChooseDifficulty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        child: AlertDialog(
          title: const Text('Choose difficulty, higher levels increase mines'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () => onChooseDifficulty(6),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[500],
                ),
                child: const Text('Easy'),
              ),
              ElevatedButton(
                onPressed: () => onChooseDifficulty(5),
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow[700],
                ),
                child: const Text('Normal'),
              ),
              ElevatedButton(
                onPressed: () => onChooseDifficulty(4),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange[700],
                ),
                child: const Text('Hard'),
              ),
              ElevatedButton(
                onPressed: () => onChooseDifficulty(3),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[700],
                ),
                child: const Text('Insane'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
