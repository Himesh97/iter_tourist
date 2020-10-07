import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iter_tourist_app/core/models/food_model.dart';
import 'package:iter_tourist_app/core/models/guide_model.dart';

class ToursView extends StatefulWidget {
  @override
  _ToursViewState createState() => _ToursViewState();
}

class _ToursViewState extends State<ToursView> {
  final _db = FirebaseFirestore.instance;
  Future _getToursList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        title: Text("Tour Guides"),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: _getToursList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && !snapshot.hasError) {
                if (snapshot.data.size == 0) {
                  return Center(
                    child: Text("No Data"),
                  );
                }
                final guideList = snapshot.data.docs
                    .map((e) => Guide.fromDocument(e))
                    .toList();
                return ListView(
                  physics: BouncingScrollPhysics(),
                  children: guideList.map((e) => _listItem(e)).toList(),
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

  Widget _listItem(Guide guide) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                guide.name,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              trailing: CircleAvatar(
                backgroundColor: guide.availability_status == "active"
                    ? Colors.green
                    : Colors.red,
                radius: 10,
              ),
            ),
            ListTile(
              subtitle: Divider(),
              title: Text(
              "Contact Details", style: TextStyle(fontSize: 20,),
            ),),
            ListTile(
              subtitle: Text(
                guide.address,
              ),
              title: Text(
                "Address",
              ),
            ),
            ListTile(
              subtitle: Text(
                guide.telephone,
              ),
              title: Text(
                "Telephone",
              ),
            ),
            ListTile(
              subtitle: Text(
                guide.email,
              ),
              title: Text(
                "Email",
              ),
            ),
            ListTile(
              subtitle: Divider(),
              title: Text(
              "Tour Expertise", style: TextStyle(fontSize: 20,),
            ),),
            ListTile(
              subtitle: Text(
                guide.language,
              ),
              title: Text(
                "Language",
              ),
            ),
            ListTile(
              subtitle: Text(
                guide.experience,
              ),
              title: Text(
                "Experience",
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
    _getToursList = _db.collection("user").get();
  }
}
