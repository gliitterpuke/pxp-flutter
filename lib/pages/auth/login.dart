import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:pxp_flutter/pages/auth/forgot_password.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pxp_flutter/pages/ig/app/app.dart';

import 'package:pxp_flutter/pages/auth/register.dart';
import 'package:pxp_flutter/pages/root_app.dart';

import 'new_password.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormBuilderState>();

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
                                "LOG IN WITH",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 40),
                            FittedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RawMaterialButton(
                                    onPressed: () {},
                                    fillColor: const Color(0xFF4267B2),
                                    child: const Icon(FontAwesome.facebook,
                                        size: 16.0, color: Colors.white),
                                    padding: const EdgeInsets.all(15.0),
                                    shape: const CircleBorder(),
                                  ),
                                  RawMaterialButton(
                                    onPressed: () {},
                                    fillColor: const Color(0xFF1DA1F2),
                                    child: const Icon(Feather.twitter,
                                        size: 16.0, color: Colors.white),
                                    padding: const EdgeInsets.all(15.0),
                                    shape: const CircleBorder(),
                                  ),
                                  RawMaterialButton(
                                    onPressed: () {},
                                    fillColor: const Color(0xFFDB4437),
                                    child: const Icon(AntDesign.google,
                                        size: 16.0, color: Colors.white),
                                    padding: const EdgeInsets.all(15.0),
                                    shape: const CircleBorder(),
                                  ),
                                  RawMaterialButton(
                                    onPressed: () {},
                                    fillColor: const Color(0xFF555555),
                                    child: const Icon(AntDesign.apple1,
                                        size: 16.0, color: Colors.white),
                                    padding: const EdgeInsets.all(15.0),
                                    shape: const CircleBorder(),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            Row(children: [
                              Expanded(
                                  child: const Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Divider(
                                    color: Color(0xFFBFBFBF), thickness: 1.25),
                              )),
                              const Center(
                                child: Text(
                                  "OR",
                                  style: TextStyle(
                                      color: Color(0xFFBFBFBF),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                  child: const Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Divider(
                                    color: Color(0xFFBFBFBF), thickness: 1.25),
                              )),
                            ]),
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
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[400], fontSize: 14)),
                                initialValue: 'demo@demo.com',
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.email(),
                                  FormBuilderValidators.required()
                                ]),
                              ),
                            ),
                            const SizedBox(height: 10),
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
                                name: 'password',
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                style: const TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[400], fontSize: 14)),
                                initialValue: "testing123",
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.match(
                                      r"(?=.*?[0-9]).{8,}$"),
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
                              print(_formKey.currentState!.value);

                              final success = await context.appState
                                  .connect(DemoAppUser.sacha);

                              if (success) {
                                await Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (_) => const RootApp(),
                                  ),
                                );
                              } else {
                                context.removeAndShowSnackbar(
                                    'Could not connect user');
                              }
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
                                "LOG IN",
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NewPassword()));
                            },
                            child: const Text("Forgot your password?",
                                style: TextStyle(
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                ))),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Register()));
                            },
                            child: const Text("Create an account",
                                style: TextStyle(
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                ))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
