import 'package:bwatch_front/animations/HUD_progress.dart';
import 'package:bwatch_front/models/register_model.dart';
import 'package:bwatch_front/screens/login_screen.dart';
import 'package:bwatch_front/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late RegisterRequestModel requestModel;
  bool isApiCallProcess = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    requestModel = new RegisterRequestModel(
        firstName: 'init',
        lastName: 'init',
        email: 'init',
        password: 'init',
        passwordConfirm: 'init');
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
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back));
        }),
        backgroundColor: Color(kPrimaryColor),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Create an account",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
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
                              if (val == null || val.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            onChanged: (input) =>
                                requestModel.firstName = input,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "First Name",
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
                              if (val == null || val.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            onChanged: (input) => requestModel.lastName = input,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Last Name",
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
                              if (val != requestModel.password) {
                                return 'Passwords don\'t match';
                              }
                              return null;
                            },
                            obscureText: true,
                            style: TextStyle(color: Colors.white),
                            onChanged: (input) =>
                                requestModel.passwordConfirm = input,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: "Confirm Password",
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
                Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 60),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color.fromRGBO(49, 39, 79, 1),
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
                        apiService.register(requestModel).then((value) {
                          setState(() {
                            isApiCallProcess = false;
                          });

                          if (value.status == 'success') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "User with such email already exists, please enter a different email address"),
                              ),
                            );
                          }
                        });
                      }
                    },
                    child: Center(
                      child: Text(
                        "Create account",
                        style: TextStyle(color: Colors.white),
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
