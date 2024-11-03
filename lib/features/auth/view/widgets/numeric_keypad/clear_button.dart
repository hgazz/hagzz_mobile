import 'package:flutter/material.dart';

import '../../../../../core/util/constants/app_colors/app_colors.dart';

class ClearButton extends StatelessWidget {
  const ClearButton({
    super.key,
    required this.onClearLastInput,
    required this.onClearAll,
  });

  final VoidCallback onClearLastInput;
  final VoidCallback onClearAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: GestureDetector(
        onLongPress: onClearAll,
        child: FilledButton(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(72, 72),
            backgroundColor: AppColors.surfaceContainer,
            shape: const CircleBorder(),
          ),
          onPressed: onClearLastInput,
          child: const Icon(
            Icons.backspace_outlined,
            // color: Color(0xFFF1F4FE),
          ),
        ),
      ),
    );
  }
}
