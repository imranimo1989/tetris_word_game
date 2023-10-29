import 'package:flutter/material.dart';

void main() {
  runApp(const AlphabetTetrisGame());
}

class AlphabetTetrisGame extends StatelessWidget {
  const AlphabetTetrisGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Alphabet Tetris'),
        ),
        body: const AlphabetTetrisBoard(),
      ),
    );
  }
}

class AlphabetTetrisBoard extends StatefulWidget {
  const AlphabetTetrisBoard({super.key});

  @override
  _AlphabetTetrisBoardState createState() => _AlphabetTetrisBoardState();
}

class _AlphabetTetrisBoardState extends State<AlphabetTetrisBoard> {
  List<String> alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
  String? currentBlock;
  int currentPosition = 4;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) => moveBlock(details),
      child: Container(
        color: Colors.black,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10,
          ),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return GridTile(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: currentPosition == index ? Colors.blue : Colors.transparent),
                  child: Center(
                    child: Text(
                      index == currentPosition ? currentBlock ?? '' : '',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    generateNewBlock();
  }

  void generateNewBlock() {
    setState(() {
      currentBlock = alphabet[DateTime.now().second % alphabet.length];
      updateBlock();
    });
  }

  void updateBlock() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (currentPosition < 9) {
          currentPosition++;
        } else {
          // Game over or handle the end of the game
        }
        generateNewBlock();
      });
    });
  }

  void moveBlock(DragUpdateDetails details) {
    setState(() {
      if (details.delta.dx > 0) {
        if (currentPosition < 9) {
          currentPosition++;
        }
      } else if (details.delta.dx < 0) {
        if (currentPosition > 0) {
          currentPosition--;
        }
      }
    });
  }
}
