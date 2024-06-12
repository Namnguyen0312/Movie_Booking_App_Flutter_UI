import 'package:flutter/material.dart';

class CustomBackArrow extends StatelessWidget {
  const CustomBackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white60,
        ));
  }
}
