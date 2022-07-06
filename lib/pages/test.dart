import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:pxp_flutter/pages/auth/forgot_password.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pxp_flutter/pages/ig/app/app.dart';

import 'package:pxp_flutter/pages/auth/register.dart';
import 'package:pxp_flutter/pages/root_app.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'ig/components/app_widgets/app_widgets.dart';

class NewTestPage extends StatefulWidget {
  const NewTestPage({Key? key}) : super(key: key);

  @override
  _NewTestPageState createState() => _NewTestPageState();
}

class _NewTestPageState extends State<NewTestPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final streamagramUser = context
        .select<AppState, StreamagramUser?>((value) => value.streamagramUser);
    if (streamagramUser == null) {
      return const Scaffold(
        body: Center(
          child: Text('You should not see this.\nUser data is empty.'),
        ),
      );
    }
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
                                "LET'S GET STARTED",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const _ChangeProfilePictureButton(),
                            const SizedBox(height: 40),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Username',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
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
                                name: 'username',
                                style: const TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText:
                                        "DemoUser (3-15 characters, one word)",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[400], fontSize: 14)),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.match(
                                      r"^[a-z0-9_-]{3,15}$"),
                                  FormBuilderValidators.required()
                                ]),
                              ),
                            ),
                            const SizedBox(height: 10),
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
                                "START YOUR JOURNEY",
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

class _ChangeProfilePictureButton extends StatefulWidget {
  const _ChangeProfilePictureButton({
    Key? key,
  }) : super(key: key);

  @override
  __ChangeProfilePictureButtonState createState() =>
      __ChangeProfilePictureButtonState();
}

class __ChangeProfilePictureButtonState
    extends State<_ChangeProfilePictureButton> {
  final _picker = ImagePicker();

  Future<void> _changePicture() async {
    if (context.appState.isUploadingProfilePicture == true) {
      return;
    }

    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 70,
    );
    if (pickedFile != null) {
      await context.appState.updateProfilePhoto(pickedFile.path);
    } else {
      context.removeAndShowSnackbar('No picture selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    final streamagramUser = context
        .select<AppState, StreamagramUser>((value) => value.streamagramUser!);
    final isUploadingProfilePicture = context
        .select<AppState, bool>((value) => value.isUploadingProfilePicture);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 150,
            child: Center(
              child: isUploadingProfilePicture
                  ? const CircularProgressIndicator()
                  : GestureDetector(
                      onTap: _changePicture,
                      child: Avatar.huge(streamagramUser: streamagramUser),
                    ),
            ),
          ),
          GestureDetector(
            onTap: _changePicture,
            child: const Text('Change Profile Photo',
                style: AppTextStyle.textStyleAction),
          ),
        ],
      ),
    );
  }
}
