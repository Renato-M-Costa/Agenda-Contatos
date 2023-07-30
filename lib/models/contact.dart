import 'package:flutter/material.dart';

class Contact with ChangeNotifier {
  int? id;
  final String name;
  final String phone;
  bool isFavorite;

  Contact({
    this.id,
    required this.name,
    required this.phone,
    this.isFavorite = false,
  });

  void toogleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
