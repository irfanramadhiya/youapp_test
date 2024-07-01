import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/bloc/profile_bloc.dart';
import 'package:flutter_application_1/favourite_edit.dart';
import 'package:flutter_application_1/gradient_text.dart';
import 'package:flutter_application_1/profile.dart';
import 'package:flutter_application_1/profile_about_data.dart';
import 'package:flutter_application_1/profile_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.xAccessToken});

  final String xAccessToken;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isEdittingAbout = false;
  String? genderValue;

  File? _selectedImage;

  bool isHeightNotEmpty = false;
  bool isWeightNotEmpty = false;

  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _birthday = TextEditingController();
  final TextEditingController _horoscope = TextEditingController();
  final TextEditingController _zodiac = TextEditingController();
  late TextEditingController _height;
  late TextEditingController _weight;

  String horoscopeHint = "--";
  String zodiacHint = "--";

  late ProfileBloc profileBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _height = TextEditingController();
    _weight = TextEditingController();

    profileBloc = BlocProvider.of<ProfileBloc>(context);

    profileBloc.add(GetProfile(widget.xAccessToken));

    _height.addListener(() {
      final isHeightNotEmpty = _height.text.isNotEmpty;
      setState(() {
        this.isHeightNotEmpty = isHeightNotEmpty;
      });
    });

    _weight.addListener(() {
      final isWeightNotEmpty = _weight.text.isNotEmpty;
      setState(() {
        this.isWeightNotEmpty = isWeightNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xff09141A),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 37,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 51,
                      ),
                      BlocBuilder<ProfileBloc, Profile>(
                        builder: (context, state) {
                          return Text(
                            "@${state.username}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          );
                        },
                      ),
                      Image.asset('assets/images/more-options.png')
                    ],
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      BlocBuilder<ProfileBloc, Profile>(
                        builder: (context, state) {
                          return Container(
                            height: 190,
                            decoration: state.image == null
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Color(0xff162329),
                                  )
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                        image: FileImage(state.image!),
                                        fit: BoxFit.cover)),
                            child: Container(
                              padding: EdgeInsets.only(left: 13, bottom: 17),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  BlocBuilder<ProfileBloc, Profile>(
                                    builder: (context, state) {
                                      return Text(
                                          "@${state.name == null || state.name == "" ? state.username : state.formattedName()}, ${state.age()}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16));
                                    },
                                  ),
                                  BlocBuilder<ProfileBloc, Profile>(
                                    builder: (context, state) {
                                      return state.gender != "" &&
                                              state.gender != null
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                BlocBuilder<ProfileBloc,
                                                    Profile>(
                                                  builder: (context, state) {
                                                    return Text(
                                                      "${state.gender}",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    );
                                                  },
                                                ),
                                              ],
                                            )
                                          : SizedBox();
                                    },
                                  ),
                                  BlocBuilder<ProfileBloc, Profile>(
                                    builder: (context, state) {
                                      return state.birthday != "" &&
                                              state.birthday != null
                                          ? Column(
                                              children: [
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color:
                                                            Color(0xff162329),
                                                      ),
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 8,
                                                                horizontal: 16),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            color:
                                                                Colors.white10),
                                                        child: Row(
                                                          children: [
                                                            Image.asset(state
                                                                .horoscopeIcon()),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              "${state.horoscope}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color:
                                                            Color(0xff162329),
                                                      ),
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 8,
                                                                horizontal: 16),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            color:
                                                                Colors.white10),
                                                        child: Row(
                                                          children: [
                                                            Image.asset(state
                                                                .zodiacIcon()),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              "${state.zodiac}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : SizedBox();
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      isEdittingAbout == false
                          ? Container(
                              padding: EdgeInsets.only(left: 27, bottom: 23),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Color(0xff0E191F),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 13),
                                        child: const Text("About",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14)),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedImage = context
                                                .read<ProfileBloc>()
                                                .state
                                                .image;
                                            _displayName.text = context
                                                    .read<ProfileBloc>()
                                                    .state
                                                    .name ??
                                                "";
                                            _birthday.text = context
                                                    .read<ProfileBloc>()
                                                    .state
                                                    .birthday ??
                                                "";
                                            horoscopeHint = context
                                                    .read<ProfileBloc>()
                                                    .state
                                                    .horoscope ??
                                                "--";
                                            zodiacHint = context
                                                    .read<ProfileBloc>()
                                                    .state
                                                    .zodiac ??
                                                "--";
                                            if (context
                                                    .read<ProfileBloc>()
                                                    .state
                                                    .height !=
                                                null) {
                                              _height.text = context
                                                  .read<ProfileBloc>()
                                                  .state
                                                  .height
                                                  .toString();
                                            }
                                            if (context
                                                    .read<ProfileBloc>()
                                                    .state
                                                    .weight !=
                                                null) {
                                              _weight.text = context
                                                  .read<ProfileBloc>()
                                                  .state
                                                  .weight
                                                  .toString();
                                            }
                                            isEdittingAbout = true;
                                          });
                                        },
                                        child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 14, top: 8),
                                            child: Image.asset(
                                                "assets/images/edit.png")),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 57),
                                    child: BlocBuilder<ProfileBloc, Profile>(
                                      builder: (context, state) {
                                        return state.isAboutDataEmpty()
                                            ? const Text(
                                                "Add in your your to help others know you better",
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14))
                                            : Column(children: [
                                                state.birthday != null &&
                                                        state.birthday != ""
                                                    ? Column(
                                                        children: [
                                                          ProfileAboutData(
                                                              title:
                                                                  "Birthday: ",
                                                              data: state
                                                                  .formattedBirthday()),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          ProfileAboutData(
                                                              title:
                                                                  "Horoscope: ",
                                                              data: state
                                                                  .horoscope!),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          ProfileAboutData(
                                                              title: "Zodiac: ",
                                                              data: state
                                                                  .zodiac!),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                        ],
                                                      )
                                                    : SizedBox(),
                                                state.height != null
                                                    ? Column(
                                                        children: [
                                                          ProfileAboutData(
                                                              title: "Height: ",
                                                              data:
                                                                  "${state.height.toString()} cm"),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                        ],
                                                      )
                                                    : SizedBox(),
                                                state.weight != null
                                                    ? ProfileAboutData(
                                                        title: "Weight: ",
                                                        data:
                                                            "${state.weight.toString()} kg")
                                                    : SizedBox(),
                                              ]);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(
                                  left: 27, right: 20, top: 15, bottom: 40),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Color(0xff0E191F),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("About",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                      GestureDetector(
                                        onTap: () {
                                          Profile profile = Profile(
                                              username: context
                                                  .read<ProfileBloc>()
                                                  .state
                                                  .username,
                                              image: _selectedImage,
                                              name: _displayName.text,
                                              gender: genderValue,
                                              birthday: _birthday.text,
                                              zodiac: zodiacHint,
                                              horoscope: horoscopeHint,
                                              height: int.parse(_height.text),
                                              weight: int.parse(_weight.text));
                                          profileBloc
                                              .add(UpdateProfile(profile));
                                          setState(() {
                                            isEdittingAbout = false;
                                          });
                                        },
                                        child: const GradientText(
                                            "Save & Update",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Color(0xff94783E),
                                                  Color(0xffF3EDA6),
                                                  Color(0xffF8FAE5),
                                                  Color(0xffFFE2BE),
                                                  Color(0xffD5BE88),
                                                  Color(0xffF8FAE5),
                                                  Color(0xffD5BE88)
                                                ])),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 31,
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _pickImageFromGallery();
                                        },
                                        child: Container(
                                            height: 57,
                                            width: 57,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(17),
                                              color: Colors.white10,
                                            ),
                                            child: _selectedImage == null
                                                ? Image.asset(
                                                    'assets/images/add-image.png')
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            17),
                                                    child: Image.file(
                                                      _selectedImage!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const Text("Add image",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 29,
                                  ),
                                  ProfileTextField(
                                      title: "Display name:",
                                      hintText: "Enter name",
                                      controller: _displayName),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Gender:",
                                        style: TextStyle(
                                            color: Colors.white30,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13),
                                      ),
                                      Container(
                                        width: 202,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white10,
                                        ),
                                        child: DropdownButton(
                                          dropdownColor: Color(0xff0E191F),
                                          underline: SizedBox(),
                                          isExpanded: true,
                                          value: genderValue,
                                          hint: Text(
                                            "Select Gender",
                                            style: const TextStyle(
                                                color: Colors.white30,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13),
                                          ),
                                          icon: Container(
                                            margin: EdgeInsets.only(
                                                left: 10, right: 12),
                                            child: Image.asset(
                                                "assets/images/dropdown.png"),
                                          ),
                                          alignment: Alignment.centerRight,
                                          style: TextStyle(color: Colors.white),
                                          onChanged: (value) {
                                            setState(() {
                                              genderValue = value!;
                                            });
                                          },
                                          items: const [
                                            DropdownMenuItem(
                                              value: "Male",
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Text(
                                                  "Male",
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: "Female",
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Text(
                                                  "Female",
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Birthday: ",
                                        style: TextStyle(
                                            color: Colors.white30,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13),
                                      ),
                                      SizedBox(
                                        width: 202,
                                        height: 36,
                                        child: TextField(
                                          textAlign: TextAlign.end,
                                          controller: _birthday,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13),
                                          readOnly: true,
                                          onTap: () {
                                            _selectDate();
                                          },
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              alignLabelWithHint: true,
                                              filled: true,
                                              hintStyle: TextStyle(
                                                  color: Colors.white30),
                                              hintText: "DD MM YYYY",
                                              fillColor: Colors.white10,
                                              floatingLabelAlignment:
                                                  FloatingLabelAlignment.center,
                                              contentPadding: EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                  right: 20)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  ProfileTextField(
                                    title: "Horoscope:",
                                    hintText: horoscopeHint,
                                    controller: _horoscope,
                                    readOnly: true,
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  ProfileTextField(
                                    title: "Zodiac:",
                                    hintText: zodiacHint,
                                    controller: _zodiac,
                                    readOnly: true,
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  ProfileTextField(
                                    title: "Height:",
                                    hintText: "Add height",
                                    controller: _height,
                                    suffixText: "cm",
                                    keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  ProfileTextField(
                                    title: "Weight:",
                                    hintText: "Add weight",
                                    controller: _weight,
                                    suffixText: "kg",
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                            ),
                      SizedBox(
                        height: 18,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 27, bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Color(0xff0E191F),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 13),
                                  child: const Text("Interest",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                const FavouriteEdit()))
                                        .then((value) => setState(() {}));
                                  },
                                  child: Container(
                                      margin:
                                          EdgeInsets.only(right: 14, top: 8),
                                      child: Image.asset(
                                          "assets/images/edit.png")),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            BlocBuilder<ProfileBloc, Profile>(
                              builder: (context, state) {
                                return state.interests == null ||
                                        state.interests == []
                                    ? Container(
                                        margin: EdgeInsets.only(right: 57),
                                        child: const Text(
                                            "Add in your interest to find a better match",
                                            style: TextStyle(
                                                color: Colors.white54,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14)),
                                      )
                                    : Container(
                                        padding: EdgeInsets.only(right: 50),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Wrap(
                                            children: state.interests!
                                                .map((String tag) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 16,
                                                        vertical: 8),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 12),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: Colors.white10),
                                                    child: Text(tag,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14)),
                                                  ),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 19,
                ),
              ],
            ),
          )),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;

    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1901),
        lastDate: DateTime.now());

    if (_picked == null) return;

    DateFormat formatter = DateFormat("dd MM yyyy");

    setState(() {
      _birthday.text = formatter.format(_picked);
      horoscopeHint = getHoroscope(_picked.day, _picked.month);
      zodiacHint = getZodiac(_picked.year);
    });
  }

  String getZodiac(int year) {
    double result = year / 12;
    int finalResult = 0;

    if (result % 1 != 0) {
      result = result - result.toInt();
      result = result * 12;
      finalResult = result.round();
    }

    switch (finalResult) {
      case 0:
        return "Monkey";
      case 1:
        return "Rooster";
      case 2:
        return "Dog";
      case 3:
        return "Pig";
      case 4:
        return "Rat";
      case 5:
        return "Ox";
      case 6:
        return "Tiger";
      case 7:
        return "Rabbit";
      case 8:
        return "Dragon";
      case 9:
        return "Snake";
      case 10:
        return "Horse";
      case 11:
        return "Goat";

      default:
        return "";
    }
  }

  String getHoroscope(int day, int month) {
    const List<String> signNames = [
      "Capricorn",
      "Aquarius",
      "Pisces",
      "Aries",
      "Taurus",
      "Gemini",
      "Cancer",
      "Leo",
      "Virgo",
      "Libra",
      "Scorpio",
      "Sagittarius",
      "Capricorn"
    ];
    const List<int> signDays = [
      0,
      22,
      20,
      21,
      21,
      22,
      23,
      23,
      23,
      23,
      23,
      22,
      22
    ];

    if (day < signDays[month]) {
      return signNames[month - 1];
    } else {
      return signNames[month];
    }
  }
}
