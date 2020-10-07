import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Tourist {
  final String firebaseUserId;
  final String fullName;
  final String accommodation;
  final DateTime arrivalDate;
  final String nativeLanguage;
  final String photoUrl;
  final String mobileNumber;

  Tourist(
      {@required this.firebaseUserId,
        @required this.fullName,
        @required this.accommodation,
        @required this.arrivalDate,
        @required this.nativeLanguage,
        @required this.photoUrl,
        @required this.mobileNumber,
      });

  Map<String, dynamic> toDocument() => <String, dynamic>{
        'firebaseUserId': firebaseUserId,
        'fullName': fullName,
        'accommodation': accommodation,
        'arrivalDate': arrivalDate,
        'nativeLanguage': nativeLanguage,
        'photoUrl': photoUrl,
        'mobileNumber': mobileNumber,
      };

  factory Tourist.fromDocument(DocumentSnapshot document) {
    return new Tourist(
      firebaseUserId: document.id,
      fullName: document.data()['fullName'] ?? "",
      accommodation: document.data()['accommodation'] ?? "",
      arrivalDate: (document.data()['arrivalDate'] as Timestamp)?.toDate() ?? DateTime.now(),
      nativeLanguage: document.data()['nativeLanguage'] ?? "",
      photoUrl: document.data()['photoUrl'] ?? "",
      mobileNumber: document.data()['mobileNumber'] ?? "",
    );
  }
}
