import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iter_tourist_app/core/models/tourist_model.dart';
import 'package:iter_tourist_app/core/services/date_formatter.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _db = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  Future _getProfileDetails;

  DateTime departDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: _getProfileDetails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && !snapshot.hasError) {
                Tourist tourist = new Tourist.fromDocument(snapshot.data);
                return SingleChildScrollView(
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          ListTile(
                            title: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: tourist.photoUrl,
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Personal Details",
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Divider(
                            color: Colors.white,
                          ),
                          _item("Name", tourist.fullName, context),
                          _item("Language", tourist.nativeLanguage, context),
                          SizedBox(height: 15),
                          Text(
                            "Travel Information",
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Divider(
                            color: Colors.white,
                          ),
                          _item(
                              "Accommodation", tourist.accommodation, context),
                          _item(
                              "Arrival Date",
                              DateFormatter.toSingle(tourist.arrivalDate),
                              context),
                          ListTile(
                            title: Text(
                              "Departure Date",
                              style:
                              TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            subtitle: Text(
                              departDateTime == null
                                  ? "Select depart time"
                                  : DateFormatter.toDateOnly(departDateTime),
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 15),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.event, color: Colors.white,),
                              onPressed: ()async {
                                final selectedDate = await showDatePicker(context: context,
                                    initialDate: DateTime.now(),
                                  firstDate: DateTime.now().subtract(Duration(days: 1000)),
                                  lastDate: DateTime.now().add(Duration(days: 1000)),
                                );
                                setState(() {
                                  departDateTime = selectedDate;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Contact Details",
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Divider(
                            color: Colors.white,
                          ),
                          _item("Mobile Number", tourist.mobileNumber, context),
                        ],
                      ),
                    ),
                  ),
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

  Widget _item(title, subtitle, context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.white70, fontSize: 15),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getProfileDetails =
        _db.collection("users").doc(_firebaseAuth.currentUser.uid).get();
  }
}
