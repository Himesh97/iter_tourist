import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iter_tourist_app/core/models/hotel_model.dart';
import 'package:iter_tourist_app/ui/screens/single_hotel_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HotelsView extends StatefulWidget {
  @override
  _HotelsViewState createState() => _HotelsViewState();
}

class _HotelsViewState extends State<HotelsView> {

  final _db = FirebaseFirestore.instance;
  Future _getHotelList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        title: Text("Hotels"),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _getHotelList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done){
            if (snapshot.hasData && !snapshot.hasError){
              if (snapshot.data.size == 0){
                return Center(child: Text("No Data"),);
              }
              final hotelList = snapshot.data.docs.map((e) => Hotel.fromDocument(e)).toList();
              return ListView(
                physics: BouncingScrollPhysics(),
                children: hotelList.map((e) => _listItem(e)).toList(),
              );
            }
            return Center(child: Text("Something went wrong. Please try again later"),);
          }
          return Center(child: CircularProgressIndicator(),);
        }
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
                      hotel.imageUrl),
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
                        _starRating(hotel.rating),
                        Text("\$${hotel.price} per night",
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
    if (value == null) value = 0;
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

  @override
  void initState() {
    super.initState();
    _getHotelList = _db.collection("hotels").get();
  }
}
