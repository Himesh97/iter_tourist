import 'package:flutter/material.dart';
import 'package:iter_tourist/core/models/hotel_model.dart';
import 'package:iter_tourist/ui/screens/single_hotel_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HotelsView extends StatefulWidget {
  @override
  _HotelsViewState createState() => _HotelsViewState();
}

class _HotelsViewState extends State<HotelsView> {
  final Hotel hotel1 = new Hotel(
      name: "Galley mariya",
      address: "Kottawa, new york, Slt",
      description:
          "Description: We thoroughly enjoyed our weekend stay at Waybourne. Our host and hostess couldn’t do enough for us. They treated us just like friends. The accommodation was fabulous, lovely spacious rooms and fabulous breakfasts. The staff was really helpful and friendly, the room was very clean and it comes with lovely view from the balcony. The room was clean, and the view from the balcony, and even from the bed was fantastic.",
      price: 650,
      rating: 4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        title: Text("Hotels"),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          _listItem(hotel1),
          _listItem(hotel1),
          _listItem(hotel1),
          _listItem(hotel1),
          _listItem(hotel1),
        ],
      ),
    );
  }

  Widget _listItem(Hotel hotel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        color: Colors.white,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SingleHotelView(
                          hotel: hotel,
                        ))),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      fit: BoxFit.fill,
                      height: 100,
                      image:
                          "https://cdn.pixabay.com/photo/2018/07/16/16/08/island-3542290_960_720.jpg"),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hotel.name,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        Text(
                          hotel.address,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54),
                        ),
                        _starRating(hotel.rating),
                        Text("\$${hotel.price} for 1 night",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.blue)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _starRating(int value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          value >= 1 ? Icons.star : Icons.star_border,
          color: Colors.orange,
          size: 20,
        ),
        Icon(
          value >= 2 ? Icons.star : Icons.star_border,
          color: Colors.orange,
          size: 20,
        ),
        Icon(
          value >= 3 ? Icons.star : Icons.star_border,
          color: Colors.orange,
          size: 20,
        ),
        Icon(
          value >= 4 ? Icons.star : Icons.star_border,
          color: Colors.orange,
          size: 20,
        ),
        Icon(
          value >= 5 ? Icons.star : Icons.star_border,
          color: Colors.orange,
          size: 20,
        ),
      ],
    );
  }
}
