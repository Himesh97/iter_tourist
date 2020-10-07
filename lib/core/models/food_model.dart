import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Food {
  final String name;
  final String imageUrl;
  final String description;

  Food(
      {@required this.name,
        @required this.imageUrl,
        @required this.description,
      });

  factory Food.fromDocument(DocumentSnapshot document) {
    return new Food(
      name: document.data()['name'] ?? "",
      imageUrl: document.data()['imageUrl'] ?? "",
      description: document.data()['description'] ?? "",

    );
  }
}
