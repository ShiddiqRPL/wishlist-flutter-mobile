import 'package:flutter/material.dart';
import 'screens/wishlist_screen.dart';

void main() {
  runApp(WishlistApp());
}

class WishlistApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wishlist App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: WishlistScreen(),
    );
  }
}
