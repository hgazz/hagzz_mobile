import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'clear_button.dart';
import 'numeral.dart';

class NumericKeyPad extends StatelessWidget {
  final void Function(int) onInputNumber;
  final VoidCallback onClearLastInput;
  final VoidCallback onClearAll;

  const NumericKeyPad({
    super.key,
    required this.onInputNumber,
    required this.onClearLastInput,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 1; i < 4; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int j = 1; j < 4; j++)
                Flexible(
                  child: Numeral(
                    number: (i - 1) * 3 + j,
                    onKeyPress: () => onInputNumber((i - 1) * 3 + j),
                  ),
                ),
            ],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(9),
              child: SizedBox(
                width: 72,
                height: 72,
              ),
            ),
            Flexible(
              child: Numeral(
                number: 0,
                onKeyPress: () => onInputNumber(0),
              ),
            ),
            Flexible(
              child: ClearButton(
                onClearLastInput: onClearLastInput,
                onClearAll: onClearAll,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
