import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For encoding/decoding list

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

class WishlistScreen extends StatefulWidget {
  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<String> _wishlist = [];

  @override
  void initState() {
    super.initState();
    _loadWishlist();
  }

  void _loadWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final String? wishlistJson = prefs.getString('wishlist');
    if (wishlistJson != null) {
      setState(() {
        _wishlist = List<String>.from(json.decode(wishlistJson));
      });
    }
  }

  void _saveWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('wishlist', json.encode(_wishlist));
  }

  void _showAddItemDialog() {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Wishlist Item'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Enter item name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newItem = _controller.text;
                if (newItem.isNotEmpty) {
                  setState(() {
                    _wishlist.add(newItem);
                    _saveWishlist();
                  });
                }
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Wishlist')),
      body: ListView.builder(
        itemCount: _wishlist.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(_wishlist[index]),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              setState(() {
                _wishlist.removeAt(index);
                _saveWishlist();
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Item deleted')),
              );
            },
            child: ListTile(
              title: Text(_wishlist[index]),
              onLongPress: () {
                setState(() {
                  _wishlist.removeAt(index);
                  _saveWishlist();
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Item deleted (long press)')),
                );
              },
              onTap: () {
                final TextEditingController _editController = TextEditingController(text: _wishlist[index]);
                
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Edit Wishlist Item'),
                      content: TextField(
                        controller: _editController,
                        decoration: InputDecoration(hintText: 'Enter new name'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close dialog
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final updatedItem = _editController.text;
                            if (updatedItem.isNotEmpty) {
                              setState(() {
                                _wishlist[index] = updatedItem;
                                _saveWishlist();
                              });
                            }
                            Navigator.of(context).pop(); // Close dialog
                          },
                          child: Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
