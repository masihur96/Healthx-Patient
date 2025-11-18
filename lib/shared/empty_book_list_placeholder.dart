import 'package:flutter/material.dart';

class EmptyBookListPlaceholder extends StatelessWidget {
  final String message;
  final IconData icon;
  final double iconSize;


  const EmptyBookListPlaceholder({
    super.key,
    this.message = "No books found",
    this.icon = Icons.menu_book_outlined,
    this.iconSize = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Icon(
            icon,
            size: iconSize,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
