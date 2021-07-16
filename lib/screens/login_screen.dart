import 'package:bwatch_front/animations/HUD_progress.dart';
import 'package:bwatch_front/constants.dart';
import 'package:bwatch_front/models/login_model.dart';
import 'package:bwatch_front/screens/main_screen.dart';
import 'package:bwatch_front/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginRequestModel requestModel;
  bool isApiCallProcess = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    requestModel = new LoginRequestModel(email: 'init', password: 'init');
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(kPrimaryColor),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 170,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Hello there, \nwelcome back",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.transparent,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: TextFormField(
                            validator: (val) {
                              if (val == null ||
                                  val.isEmpty ||
                                  !val.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            onChanged: (input) => requestModel.email = input,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: TextFormField(
                            validator: (val) {
                              if (val!.length < 8) {
                                return 'Password must have at least 8 characters';
                              }
                              return null;
                            },
                            obscureText: true,
                            style: TextStyle(color: Colors.white),
                            onChanged: (input) => requestModel.password = input,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      width: 150,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isApiCallProcess = true;
                          });

                          APIService apiService = new APIService();

                          apiService.login(requestModel).then((value) {
                            setState(() {
                              isApiCallProcess = false;
                            });

                            if (value.status == 'success') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen(
                                            firstName: value.firstName,
                                            token: value.token,
                                          )));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Incorrect email or password")));
                            }
                          });
                        }
                      },
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      width: 150,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      child: Center(
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
