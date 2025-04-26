import 'dart:convert';

class WishlistItem {
  String title;
  DateTime? dueDate;
  String category;
  bool isDone;

  WishlistItem({
    required this.title,
    this.dueDate,
    this.category = '',
    this.isDone = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'dueDate': dueDate?.toIso8601String(),
      'category': category,
      'isDone': isDone,
    };
  }

  factory WishlistItem.fromMap(Map<String, dynamic> map) {
    return WishlistItem(
      title: map['title'] ?? '',
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
      category: map['category'] ?? '',
      isDone: map['isDone'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory WishlistItem.fromJson(String source) =>
      WishlistItem.fromMap(json.decode(source));
}
