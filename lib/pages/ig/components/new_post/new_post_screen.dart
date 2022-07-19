import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stream_feed_flutter_core/stream_feed_flutter_core.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../app/app.dart';
import '../app_widgets/app_widgets.dart';

/// Screen to choose photos and add a new feed post.
class NewPostScreen extends StatefulWidget {
  /// Create a [NewPostScreen].
  const NewPostScreen({Key? key}) : super(key: key);

  /// Material route to this screen.
  static Route get route =>
      MaterialPageRoute(builder: (_) => const NewPostScreen());

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  static const double maxImageHeight = 1000;
  static const double maxImageWidth = 800;

  final _formKey = GlobalKey<FormBuilderState>();
  final _text = TextEditingController();

  XFile? _pickedFile;
  bool loading = false;

  final picker = ImagePicker();

  Future<void> _pickFile() async {
    _pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: maxImageHeight,
      maxWidth: maxImageWidth,
      imageQuality: 70,
    );
    setState(() {});
  }

  Future<void> _postImage(Map<String, dynamic> value) async {
    print(value);
    // if (!value.validate()) {
    //   print("validation failed");
    // } else {
    //   _setLoading(true);

    final client = context.appState.client;
    if (_pickedFile == null) {
      await FeedProvider.of(context).bloc.onAddActivity(
        feedGroup: 'user',
        verb: 'post',
        object: 'image',
        data: {'description': value['description'], 'title': value['title']},
      );
    } else {
      var decodedImage =
          await decodeImageFromList(await _pickedFile!.readAsBytes());

      final imageUrl =
          await client.images.upload(AttachmentFile(path: _pickedFile!.path));

      if (imageUrl != null) {
        final _resizedUrl = await client.images.getResized(
          imageUrl,
          const Resize(300, 300),
        );

        if (_pickedFile == null) {
          await FeedProvider.of(context).bloc.onAddActivity(
            feedGroup: 'user',
            verb: 'post',
            object: 'image',
            data: {
              'description': value['description'],
              'title': value['title']
            },
          );
        } else if (_resizedUrl != null && client.currentUser != null) {
          await FeedProvider.of(context).bloc.onAddActivity(
            feedGroup: 'user',
            verb: 'post',
            object: 'image',
            data: {
              'description': value['description'],
              'title': value['title'],
              'image_url': imageUrl,
              'resized_image_url': _resizedUrl,
              'image_width': decodedImage.width,
              'image_height': decodedImage.height,
              'aspect_ratio': decodedImage.width / decodedImage.height
            },
          );
        }
      }
    }

    _setLoading(false, shouldCallSetState: false);
    context.removeAndShowSnackbar('Post created!');

    Navigator.of(context).pop();
    // }
  }

  void _setLoading(bool state, {bool shouldCallSetState = true}) {
    if (loading != state) {
      loading = state;
      if (shouldCallSetState) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TapFadeIcon(
          onTap: () => Navigator.pop(context),
          icon: Icons.close,
          iconColor: Theme.of(context).appBarTheme.iconTheme!.color!,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  // _formKey.currentState!.validate();
                  _formKey.currentState!.save();
                  if (_formKey.currentState!.validate()) {
                    _postImage(_formKey.currentState!.value);
                  } else {
                    print("validation failed");
                  }
                },
                child: const Text('Share', style: AppTextStyle.textStyleAction),
              ),
            ),
          )
        ],
      ),
      body: loading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('Uploading...')
                ],
              ),
            )
          : ListView(
              children: [
                InkWell(
                  onTap: _pickFile,
                  child: SizedBox(
                    height: 400,
                    child: (_pickedFile != null)
                        ? FadeInImage(
                            fit: BoxFit.contain,
                            placeholder: MemoryImage(kTransparentImage),
                            image: Image.file(File(_pickedFile!.path)).image,
                          )
                        : Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: <Color>[
                                    Color(0xff12c2e9),
                                    Color(0xffc471ed),
                                    Color(0xfff64f59)
                                  ]),
                            ),
                            height: 300,
                            child: const Center(
                              child: Text(
                                'Add an image (optional)',
                                style: TextStyle(
                                  color: AppColors.light,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                FormBuilder(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          name: 'title',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                          decoration: const InputDecoration(
                            hintText: 'Headline / title',
                            hintStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                            border: InputBorder.none,
                          ),
                          maxLines: 2,
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required()]),
                        ),
                        FormBuilderTextField(
                          name: 'description',
                          decoration: const InputDecoration(
                            hintText: 'Tell us your story',
                            border: InputBorder.none,
                          ),
                          maxLines: null,
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required()]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
