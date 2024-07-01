import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/gradient_icon.dart';
import 'package:flutter_application_1/gradient_text.dart';
import 'package:flutter_application_1/profile_view.dart';
import 'package:flutter_application_1/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isHidden = true;
  bool isEmailNotEmpty = false;
  bool isPasswordNotEmpty = false;
  String errorMsg = "";
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _email = TextEditingController();
    _password = TextEditingController();

    _email.addListener(() {
      final isEmailNotEmpty = _email.text.isNotEmpty;
      setState(() {
        this.isEmailNotEmpty = isEmailNotEmpty;
      });
    });

    _password.addListener(() {
      final isPasswordNotEmpty = _password.text.isNotEmpty;
      setState(() {
        this.isPasswordNotEmpty = isPasswordNotEmpty;
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
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background-1.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(left: 41),
                child: const Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 24),
                )),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _email,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 13),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.white30),
                      hintText: "Enter Username/Email",
                      fillColor: Colors.white10,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: _password,
                    obscureText: isHidden,
                    obscuringCharacter: '*',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 13),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.white30),
                        hintText: "Enter Password",
                        fillColor: Colors.white10,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isHidden = !isHidden;
                              });
                            },
                            child: isHidden
                                ? const GradientIcon(
                                    Icon(
                                      Icons.visibility_off_outlined,
                                      color: Color(0xfff7f5cd),
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
                                        ]))
                                : const GradientIcon(
                                    Icon(
                                      Icons.visibility_outlined,
                                      color: Color(0xfff7f5cd),
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
                                        ])))),
                  ),
                  errorMsg == ""
                      ? const SizedBox(
                          height: 25,
                        )
                      : Container(
                          height: 25,
                          child: Text(
                            errorMsg,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                  isEmailNotEmpty && isPasswordNotEmpty
                      ? Container(
                          height: 48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xff62CDCB),
                                  Color(0xff4599DB),
                                ]),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.lightBlueAccent,
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_password.text.length < 8) {
                                setState(() {
                                  errorMsg =
                                      "Password must be longer than or equal to 8 characters";
                                });
                              } else {
                                setState(() {
                                  errorMsg = "";
                                });
                                await postLogin(_email.text, _password.text);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent),
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: 48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xff62CDCB),
                                  Color(0xff4599DB),
                                ]),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ElevatedButton(
                            onPressed: null,
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent),
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 52,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "No Account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Register()));
                        },
                        child: const GradientText("Register here",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline),
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
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> postLogin(String emailOrUsername, String password) async {
    bool isSuccess = false;
    try {
      var response = await Dio().post('https://techtest.youapp.ai/api/login',
          data: {
            'email': emailOrUsername,
            'username': "",
            'password': password
          });

      if (response.data["access_token"] == null) {
        errorMsg = response.data["message"];
      } else {
        _email.text = "";
        _password.text = "";
        errorMsg = "";

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ProfileView(xAccessToken: response.data['access_token'])));
      }
    } on DioException catch (e) {
      errorMsg = e.response?.data["message"][0];
    }

    try {
      var response = await Dio().post('https://techtest.youapp.ai/api/login',
          data: {
            'email': "",
            'username': emailOrUsername,
            'password': password
          });

      if (response.data["access_token"] == null) {
        setState(() {
          if (errorMsg == response.data["message"]) {
            errorMsg = response.data["message"];
          } else {
            errorMsg = "$errorMsg or ${response.data["message"]}";
          }
        });
      } else {
        _email.text = "";
        _password.text = "";
        errorMsg = "";

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ProfileView(xAccessToken: response.data['access_token'])));
      }
    } on DioException catch (e) {
      setState(() {
        if (errorMsg == e.response?.data["message"][0]) {
          errorMsg = e.response?.data["message"][0];
        } else {
          errorMsg = "$errorMsg or ${e.response?.data["message"][0]}";
        }
      });
    }
  }
}
