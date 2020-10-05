import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iter_tourist/core/models/tourist_model.dart';
import 'package:iter_tourist/ui/screens/hotels_view.dart';
import 'package:iter_tourist/ui/shared_widgets/busy_loader.dart';
import 'package:iter_tourist/ui/shared_widgets/error_load.dart';
import 'package:oktoast/oktoast.dart';
import 'package:transparent_image/transparent_image.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _db = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  bool isMenuOpen = false;

  Future _getUserFuture;

  Future<Tourist> _getUser() async {
    final userDoc =
        await _db.collection('users').doc(_firebaseAuth.currentUser.uid).get();
    return Tourist.fromDocument(userDoc);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Tourist>(
        future: _getUserFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!(snapshot.hasError)) {
              final Tourist tourist = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.only(left: 18, right: 18, top: 30),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(45))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                width: 50,
                                height: 50,
                                image: tourist.photoUrl),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(tourist.fullName,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500)),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              _firebaseAuth.signOut();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text(
                          "Hello, ${tourist.fullName.split(' ').first}",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  width: double.maxFinite,
                                  image:
                                      "https://cdn.pixabay.com/photo/2018/07/16/16/08/island-3542290_960_720.jpg"),
                            ),
                            Positioned(
                              left: 20,
                              bottom: 70,
                              child: RaisedButton(
                                onPressed: () async {
                                  ScanResult result = await BarcodeScanner.scan();
                                  if (result.type == ResultType.Barcode) {
                                    final String rawContent = result.rawContent;
                                    showToast(rawContent);
                                  }
                                  else showToast("Error, Try again later");
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45)),
                                child: Text("Scan Code"),
                                color: Colors.white,
                                textColor: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text(
                          "Explore our services",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        _listItem(
                            Icons.collections_bookmark,
                            "Hotels",
                            Colors.pink.withOpacity(0.35),
                            Colors.pink,
                            () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HotelsView()))),
                        _listItem(
                            Icons.collections_bookmark,
                            "Food & Drinks",
                            Colors.purple.withOpacity(0.35),
                            Colors.purple,
                            () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HotelsView()))),
                        _listItem(
                            Icons.collections_bookmark,
                            "Activities",
                            Colors.green.withOpacity(0.35),
                            Colors.green,
                            () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HotelsView()))),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  )
                ],
              );
            }
            return ErrorLoad();
          }
          return BusyLoader();
        });
  }

  Widget _listItem(icon, name, color1, color2, onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: color1,
                          radius: 30,
                        ),
                        Icon(
                          icon,
                          color: color2,
                          size: 25,
                        ),
                      ],
                    ),
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getUserFuture = _getUser();
  }
}
