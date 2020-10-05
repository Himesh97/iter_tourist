import 'package:flutter/material.dart';
import 'package:iter_tourist/core/models/hotel_model.dart';
import 'package:transparent_image/transparent_image.dart';

class SingleHotelView extends StatefulWidget {
  SingleHotelView({this.hotel});

  final Hotel hotel;

  @override
  _SingleHotelViewState createState() => _SingleHotelViewState();
}

class _SingleHotelViewState extends State<SingleHotelView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: true,
            actions: [
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {},
              )
            ],
            expandedHeight: MediaQuery.of(context).size.height * 0.28,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height * 0.28,
                      image:
                          "https://cdn.pixabay.com/photo/2018/07/16/16/08/island-3542290_960_720.jpg"),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: RaisedButton(
                      child: Text("Book Now"),
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text(
                  widget.hotel.name,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                subtitle: Text(
                  widget.hotel.address,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54),
                ),
              ),
              ListTile(
                title: _starRating(widget.hotel.rating),
              ),
              ListTile(
                title: Text("\$${widget.hotel.price}",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87)),
              ),
              ListTile(
                subtitle: Text(
                  widget.hotel.description,
                  textAlign: TextAlign.justify,
                ),
              ),
              ListTile(
                title: Text("Facilities"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.smoking_rooms,
                    color: Theme.of(context).primaryColor,
                    size: 40,
                  ),
                  Icon(
                    Icons.room_service,
                    color: Theme.of(context).primaryColor,
                    size: 40,
                  ),
                  Icon(
                    Icons.airline_seat_legroom_extra,
                    color: Theme.of(context).primaryColor,
                    size: 40,
                  ),
                  Icon(
                    Icons.date_range,
                    color: Theme.of(context).primaryColor,
                    size: 40,
                  ),
                ],
              ),
            ]),
          ),
        ],
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
