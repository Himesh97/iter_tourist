import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import 'core/data/my_colors.dart';
import 'ui/screens/startup_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      duration: Duration(seconds: 3),
      backgroundColor: Colors.black,
      position: ToastPosition.bottom,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'iTer Tourist',
        theme: buildThemeData,
        home: StartupView(),
      ),
    );
  }

  ThemeData get buildThemeData {
    final baseTheme = ThemeData.light();

    return baseTheme.copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: kPrimaryColor,
      primaryColorDark: kPrimaryColorDark,
      accentColor: kAccentColor,
      brightness: Brightness.light,
      cursorColor: kPrimaryColor,
    );
  }
}
