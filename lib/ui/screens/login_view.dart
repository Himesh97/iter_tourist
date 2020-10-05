import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iter_tourist/core/data/my_colors.dart';
import 'package:iter_tourist/core/services/validator.dart';
import 'package:oktoast/oktoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _firebaseAuth = FirebaseAuth.instance;

  String _email, _password;
  bool isLoading = false;

  void _onSavedEmail(String value) {
    _email = value.trim();
  }

  void _onSavedPassword(String value) {
    _password = value;
  }

  _onPressSignIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        isLoading = true;
      });
      try{
        await _firebaseAuth.signInWithEmailAndPassword(
            email: _email, password: _password);
      }
      catch (e){
        showToast(e.message);
      }
      setState(() {
        isLoading = false;
      });
    } else
      showToast("Please check all the fields");
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            color: Theme.of(context).primaryColor,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "iTer",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 72,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Tourist",
                    style: TextStyle(
                        color: kHighlightColor,
                        fontSize: 24,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: IgnorePointer(
              ignoring: isLoading,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hintText: "E-mail",
                            prefixIcon: Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: _onSavedEmail,
                          validator: Validator.emailValidator,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: _onSavedPassword,
                          obscureText: true,
                          validator: Validator.textValidator,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ButtonTheme(
                    minWidth: double.maxFinite,
                    height: 50,
                    child: RaisedButton(
                      child: isLoading ? CircularProgressIndicator() : Text("Sign In"),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: _onPressSignIn,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    child: Text(
                      "Forgot your password?",
                      style: TextStyle(color: Colors.black54),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
