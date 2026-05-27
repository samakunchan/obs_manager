import 'package:flutter/material.dart';

class MenuBurgerSidebar extends StatelessWidget {
  const MenuBurgerSidebar({required this.onDrawerPressed, super.key});
  final VoidCallback onDrawerPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: IconButton(
        onPressed: onDrawerPressed,
        icon: const Icon(Icons.menu),
        tooltip: 'Open Station Drawer',
      ),
    );
  }
}
