import 'package:flutter/material.dart';

class CustomKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;
  final VoidCallback onSwapPressed;

  CustomKeyboard({required this.onKeyPressed, required this.onSwapPressed});

  @override
  Widget build(BuildContext context) {
    final List<String> keys = [
      '7',
      '8',
      '9',
      'C',
      '4',
      '5',
      '6',
      '',
      '1',
      '2',
      '3',
      'DEL',
      '00',
      '0',
      '.',
      'SWAP',
    ];

    return Container(
      color: Colors.white,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: keys.length,
        itemBuilder: (context, index) {
          final key = keys[index];
          return GestureDetector(
            onTap: key.isEmpty
                ? null
                : () {
                    if (key == 'SWAP') {
                      onSwapPressed();
                    } else {
                      onKeyPressed(key);
                    }
                  },
            child: Card(
              child: Center(
                child: Text(
                  key == 'SWAP' ? '⇄' : key,
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
