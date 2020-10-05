import 'package:flutter/foundation.dart';

class Hotel {
  final String name;
  final String address;
  final String description;
  final int rating;
  final int price;

  Hotel(
      {@required this.name,
        @required this.address,
        @required this.description,
        @required this.rating,
        @required this.price,
      });
}
