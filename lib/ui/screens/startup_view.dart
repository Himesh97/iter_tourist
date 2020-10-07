import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iter_tourist_app/ui/shared_widgets/busy_loader.dart';
import 'package:iter_tourist_app/ui/shared_widgets/error_load.dart';

import 'home_view.dart';
import 'login_view.dart';

class StartupView extends StatefulWidget {
  @override
  _StartupViewState createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  final _firebaseAuth = FirebaseAuth.instance;
  Stream<User> _onAuthStateChange;

  @override
  void initState() {
    super.initState();
    _onAuthStateChange = _firebaseAuth.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: StreamBuilder<User>(
        stream: _onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (!snapshot.hasError) {
              final user = snapshot.data;
              if (user is User) {
                return Home();
              } else
                return Login();
            }
            return ErrorLoad();
          }
          return BusyLoader();
        },
      ),
    );
  }
}
