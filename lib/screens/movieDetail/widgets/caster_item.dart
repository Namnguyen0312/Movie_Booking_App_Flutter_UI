import 'package:flutter/material.dart';

class CasterItem extends StatelessWidget {
  final String name;

  const CasterItem({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(name),
    );
  }
}
