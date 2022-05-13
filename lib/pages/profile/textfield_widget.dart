import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final int maxLines;
  final String label;
  final String text;
  final ValueChanged<String> onChanged;

  const TextFieldWidget({
    Key? key,
    this.maxLines = 1,
    required this.label,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Container(
            padding:
                EdgeInsets.only(top: 4.0, bottom: 4.0, left: 15.0, right: 15.0),
            decoration: BoxDecoration(
              color: Color(0xFF212124),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: controller,
              style: TextStyle(fontSize: 14),
              maxLines: widget.maxLines,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Tell us about you',
                  isDense: true,
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14)),
            ),
          )
        ],
      );
}
