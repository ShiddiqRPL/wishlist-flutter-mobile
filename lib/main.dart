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
  List<WishlistItem> _wishlist = [];

  @override
  void initState() {
    super.initState();
    _loadWishlist();
  }

  void _loadWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final String? wishlistJson = prefs.getString('wishlist');
    if (wishlistJson != null) {
      final List<dynamic> decoded = json.decode(wishlistJson);
      setState(() {
        _wishlist = decoded.map((item) => WishlistItem.fromMap(item)).toList();
      });
    }
  }

  void _saveWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> mappedWishlist = _wishlist.map((item) => item.toMap()).toList();
    await prefs.setString('wishlist', json.encode(mappedWishlist));
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
                final newItemText = _controller.text;
                if (newItemText.isNotEmpty) {
                  final newItem = WishlistItem(title: newItemText);
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
            key: Key(item.title),
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
              title: Text(item.title),
              subtitle: item.dueDate != null
                ? Text('Due: ${item.dueDate!.toLocal().toString().split(' ')[0]}')
                : null,
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
