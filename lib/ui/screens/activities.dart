import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iter_tourist_app/core/models/activity_model.dart';
import 'package:iter_tourist_app/core/models/food_model.dart';
import 'package:iter_tourist_app/ui/screens/single_food_view.dart';
import 'package:iter_tourist_app/ui/screens/single_hotel_view.dart';
import 'package:transparent_image/transparent_image.dart';

class ActivitiesView extends StatefulWidget {
  @override
  _ActivitiesViewState createState() => _ActivitiesViewState();
}

class _ActivitiesViewState extends State<ActivitiesView> {
  final _db = FirebaseFirestore.instance;
  Future _getFoodList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        title: Text("Activities"),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: _getFoodList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && !snapshot.hasError) {
                if (snapshot.data.size == 0) {
                  return Center(
                    child: Text("No Data"),
                  );
                }
                final activityList = snapshot.data.docs
                    .map((e) => Activity.fromDocument(e))
                    .toList();
                return ListView(
                  physics: BouncingScrollPhysics(),
                  children: activityList.map((e) => _listItem(e)).toList(),
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
    );
  }

  Widget _listItem(Activity activity) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  fit: BoxFit.fill,
                  height: 100,
                  image:
                  activity.imageUrl),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  activity.name,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getFoodList = _db.collection("activities").get();
  }
}
