import 'package:flutter/material.dart';

class ProfileTextField extends StatefulWidget {
  const ProfileTextField(
      {super.key,
      required this.title,
      required this.hintText,
      required this.controller,
      this.readOnly = false,
      this.textStyle = const TextStyle(
          color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13),
      this.suffixText = "",
      this.keyboardType = TextInputType.text});

  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool readOnly;
  final TextStyle textStyle;
  final String suffixText;
  final TextInputType keyboardType;

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
              color: Colors.white30, fontWeight: FontWeight.w500, fontSize: 13),
        ),
        SizedBox(
          width: 202,
          height: 36,
          child: TextField(
            keyboardType: widget.keyboardType,
            readOnly: widget.readOnly,
            textAlign: TextAlign.end,
            controller: widget.controller,
            style: widget.textStyle,
            decoration: InputDecoration(
                suffix:
                    widget.suffixText != "" && widget.controller.text.isNotEmpty
                        ? Text(widget.suffixText, style: widget.textStyle)
                        : const SizedBox(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                alignLabelWithHint: true,
                filled: true,
                hintStyle: const TextStyle(color: Colors.white30),
                hintText: widget.hintText,
                fillColor: Colors.white10,
                floatingLabelAlignment: FloatingLabelAlignment.center,
                contentPadding:
                    const EdgeInsets.only(top: 10, bottom: 10, right: 20)),
          ),
        ),
      ],
    );
  }
}
