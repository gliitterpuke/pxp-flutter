import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pxp_flutter/pages/auth/login.dart';
import 'package:pxp_flutter/pages/ig/app/app.dart';
import 'dart:async';
import 'dart:convert';

import 'package:pxp_flutter/pages/root_app.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormBuilderState>();

  Future<void> sendPassword(Map<String, dynamic> value) async {
    final url = Uri.parse(
        'http://localhost:5000/api/v1/email/send-password-reset-email/${value}');
    final headers = {"Content-type": "application/json"};
    var jsonBody = jsonEncode(value);
    try {
      print(jsonBody);
      final response = await http.post(url, headers: headers, body: jsonBody);
      if (kDebugMode) {
        print('Status code: ${response.statusCode}');
        print('Body: ${response.body}');
      }

      if (response.statusCode != 200) {
        var error = json.decode(response.body);
        context.removeAndShowSnackbar(error['detail']);
      } else {
        print('yay');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              const Center(
                                child: Text(
                                  "FORGOT YOUR PASSWORD?",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "We'll email you instructions on how to reset it",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFBFBFBF),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 4.0,
                                    bottom: 4.0,
                                    left: 15.0,
                                    right: 15.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF212124),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: FormBuilderTextField(
                                  name: 'email',
                                  style: const TextStyle(fontSize: 14),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Your email address",
                                      hintStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14)),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.email(),
                                    FormBuilderValidators.required()
                                  ]),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () async {
                              _formKey.currentState!.save();
                              if (_formKey.currentState!.validate()) {
                                sendPassword(_formKey.currentState!.value);
                              } else {
                                print("validation failed");
                              }
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ])),
                              child: const Center(
                                child: Text(
                                  "REQUEST RESET LINK",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (_) => const Login(),
                                  ),
                                );
                              },
                              child: const Text("Back to Login",
                                  style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ))),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
