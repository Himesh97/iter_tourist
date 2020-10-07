import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Hotel {
  final String name;
  final String imageUrl;
  final String description;
  final int rating;
  final int price;

  Hotel(
      {@required this.name,
        @required this.imageUrl,
        @required this.description,
        @required this.rating,
        @required this.price,
      });

  factory Hotel.fromDocument(DocumentSnapshot document) {
    return new Hotel(
      name: document.data()['name'] ?? "",
      imageUrl: document.data()['imageUrl'] ?? "",
      description: document.data()['description'] ?? "",
      rating: document.data()['rating'] ?? 0,
      price: document.data()['price'] ?? 0,
    );
  }
}
