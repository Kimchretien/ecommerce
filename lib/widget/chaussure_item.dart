import 'package:flutter/material.dart';
class ChaussureItem extends StatelessWidget{
  final String name;
  final IconData icon;
  final VoidCallback onTap;
  const ChaussureItem({
    super.key,
    required this.name,
    required this.icon,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

    );
  }
}