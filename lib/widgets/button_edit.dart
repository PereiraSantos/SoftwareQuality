import 'package:flutter/material.dart';

class ButtonEdit extends StatelessWidget {
  const ButtonEdit({super.key, required this.onTap});

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: const SizedBox(
        width: 25,
        height: 20,
        child: Icon(
          Icons.edit,
          size: 14,
          color: Colors.blue,
        ),
      ),
    );
  }
}
