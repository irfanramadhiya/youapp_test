import 'package:flutter/material.dart';

class ProfileAboutData extends StatefulWidget {
  const ProfileAboutData({super.key, required this.title, required this.data});

  final String title;
  final String data;

  @override
  State<ProfileAboutData> createState() => _ProfileAboutDataState();
}

class _ProfileAboutDataState extends State<ProfileAboutData> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.title,
          style: const TextStyle(
              color: Colors.white30, fontWeight: FontWeight.w500, fontSize: 13),
        ),
        Text(
          widget.data,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13),
        ),
      ],
    );
  }
}
