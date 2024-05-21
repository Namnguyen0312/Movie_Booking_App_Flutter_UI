import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String textBtn;

  const MyButton({super.key, required this.onTap, required this.textBtn});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 80),
        child: Center(
          child: Text(
            textBtn,
            style: TextStyle(
                color: Colors.grey.shade200,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
      ),
    );
  }
}
