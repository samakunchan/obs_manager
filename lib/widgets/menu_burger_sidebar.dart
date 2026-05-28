import 'package:flutter/material.dart';

class MenuBurgerSidebar extends StatelessWidget {
  const MenuBurgerSidebar({required this.onDrawerPressed, super.key});
  final void Function()? onDrawerPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FloatingActionButton(
        onPressed: onDrawerPressed,
        tooltip: 'Open Station Drawer',
        mini: true,
        child: const Icon(Icons.menu),
      ),
    );
  }
}
