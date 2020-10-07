import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Activity {
  final String name;
  final String imageUrl;

  Activity(
      {@required this.name,
        @required this.imageUrl,
      });

  factory Activity.fromDocument(DocumentSnapshot document) {
    return new Activity(
      name: document.data()['name'] ?? "",
      imageUrl: document.data()['imageUrl'] ?? "",

    );
  }
}
