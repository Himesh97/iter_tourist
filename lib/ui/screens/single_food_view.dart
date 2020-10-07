import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iter_tourist_app/core/models/food_model.dart';
import 'package:transparent_image/transparent_image.dart';

class SingleFoodView extends StatefulWidget {
  SingleFoodView({this.food});

  final Food food;

  @override
  _SingleFoodViewState createState() => _SingleFoodViewState();
}

class _SingleFoodViewState extends State<SingleFoodView> {

  final _db = FirebaseFirestore.instance;
  Future _getFoodList;

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
                          widget.food.imageUrl),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: RaisedButton(
                      child: Text("Order Now"),
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
                  widget.food.name,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ),
              ListTile(
                subtitle: Text(
                  widget.food.description,
                  textAlign: TextAlign.justify,
                ),
              ),
              ListTile(
                title: Text("Related Items", style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ]),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 220,
              child: FutureBuilder<QuerySnapshot>(
                  future: _getFoodList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData && !snapshot.hasError) {
                        if (snapshot.data.size == 0) {
                          return Center(
                            child: Text("No Data"),
                          );
                        }
                        final foodList = snapshot.data.docs
                            .map((e) => Food.fromDocument(e))
                            .toList();
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: foodList.map((e) => _relatedFood(e.name, e.imageUrl)).toList(),
                        );
                      }
                      return Center(
                        child: Text("Something went wrong. Please try again later"),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _relatedFood(String name, String imageUrl){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                fit: BoxFit.fill,
                height: 150,
                image:
                imageUrl),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(name,style: TextStyle(fontSize: 18),),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getFoodList = _db.collection("foods").limit(5).get();
  }

}
