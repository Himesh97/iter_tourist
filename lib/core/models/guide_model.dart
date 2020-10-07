import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Guide {
  final String name;
  final String address;
  final String availability_status;
  final String language;
  final String email;
  final String telephone;
  final String experience;

  Guide({
    @required this.name,
    @required this.address,
    @required this.availability_status,
    @required this.language,
    @required this.email,
    @required this.telephone,
    @required this.experience,
  });

  factory Guide.fromDocument(DocumentSnapshot document) {
    return new Guide(
      name: document.data()['name'] ?? "",
      address: document.data()['address'] ?? "",
      availability_status: document.data()['availability_status'] ?? "active",
      language: document.data()['language'] ?? "" ,
      email: document.data()['email'] ?? "",
      telephone: document.data()['telephone'] ?? "",
      experience: document.data()['experience'] ?? "",
    );
  }
}
