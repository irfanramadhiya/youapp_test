import 'dart:io';

import 'package:flutter/material.dart';

class Profile {
  String username = "";
  String? name;
  String? birthday;
  String? horoscope;
  String? zodiac;
  int? height;
  int? weight;
  List<String>? interests;

  File? image;
  String? gender;

  Profile(
      {required this.username,
      this.name,
      this.birthday,
      this.horoscope,
      this.zodiac,
      this.height,
      this.weight,
      this.interests,
      this.image,
      this.gender});

  String age() {
    if (birthday == null || birthday == "") {
      return "";
    }

    DateTime now = DateTime.now();
    List<String> dob = birthday!.split(" ");

    final year = now.year - int.parse(dob[2]);
    final month = now.month - int.parse(dob[1]);

    if (month < 0) {
      return (year - 1).toString();
    } else {
      return year.toString();
    }
  }

  bool isAboutDataEmpty() {
    if (birthday != null || birthday != "") {
      return false;
    }
    if (height != null) {
      return false;
    }
    if (weight != null) {
      return false;
    }
    return true;
  }

  String formattedBirthday() {
    List<String> dob = birthday!.split(" ");
    return "${dob[0]} / ${dob[1]} / ${dob[2]} (Age ${age()})";
  }

  String formattedName() {
    if (name == null || name == "") {
      return "";
    }
    String newName = name!.replaceAll(" ", "");
    return newName.toLowerCase();
  }

  String zodiacIcon() {
    // return "assets/images/${zodiac!.toLowerCase()}.png";
    return "assets/images/pig.png";
  }

  String horoscopeIcon() {
    // return "assets/images/${horoscope!.toLowerCase()}.png";
    return "assets/images/virgo.png";
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        username: json['username'],
        name: json['name'],
        birthday: json['birthday'],
        horoscope: json['horoscope'],
        zodiac: json['zodiac'],
        height: json['height'],
        weight: json['weight'],
        interests: List.from(json['interests']));
  }
}
