import 'package:flutter/material.dart';

class BotonCarrito extends StatelessWidget {
  final VoidCallback onPressed;

  const BotonCarrito({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(Icons.shopping_cart),
    );
  }
}
