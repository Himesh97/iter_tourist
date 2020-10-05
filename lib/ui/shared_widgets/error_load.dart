import 'package:flutter/material.dart';

class ErrorLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: Colors.red,
          ),
          SizedBox(
            height: 50,
          ),
          ListTile(
            title: Center(
              child: Text("Something went wrong"),
            ),
            subtitle: Center(
              child: Text(
                  "Data loading error. Please check your connection or try again later"),
            ),
          ),
        ],
      ),
    );
  }
}
