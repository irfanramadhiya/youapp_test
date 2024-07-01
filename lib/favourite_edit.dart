import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/bloc/profile_bloc.dart';
import 'package:flutter_application_1/gradient_text.dart';
import 'package:flutter_application_1/profile.dart';
import 'package:flutter_application_1/interest_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteEdit extends StatefulWidget {
  const FavouriteEdit({super.key});

  @override
  State<FavouriteEdit> createState() => _FovouriteEditState();
}

class _FovouriteEditState extends State<FavouriteEdit> {
  late ProfileBloc profileBloc;
  List<String> interest = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    profileBloc = BlocProvider.of<ProfileBloc>(context);

    profileBloc.add(GetProfile(xAccessToken));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background-1.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 81,
            ),
            Container(
              margin: EdgeInsets.only(left: 18, right: 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Image.asset('assets/images/back-icon.png'),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Back",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        )
                      ],
                    ),
                  ),
                  BlocBuilder<ProfileBloc, Profile>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          Profile newProfile = state;
                          newProfile.interests = interest;
                          print(interest);
                          profileBloc.add(UpdateProfile(newProfile));
                          Navigator.of(context).pop();
                        },
                        child: const GradientText("Save",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xffABFFFD),
                                  Color(0xff4599DB),
                                  Color(0xffAADAFF),
                                ])),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 73,
            ),
            Container(
              margin: EdgeInsets.only(left: 35),
              child: const GradientText("Tell everyone about yourself",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
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
            SizedBox(
              height: 12,
            ),
            Container(
              margin: EdgeInsets.only(left: 35),
              child: const Text(
                "What interest you?",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            BlocBuilder<ProfileBloc, Profile>(
              builder: (context, state) {
                interest = state.interests ?? [];
                return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: InterestTextField(
                      interestFromApi: interest,
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
