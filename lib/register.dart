import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/gradient_icon.dart';
import 'package:flutter_application_1/gradient_text.dart';
import 'package:flutter_application_1/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isHidden = true;
  bool isHiddenConfirm = true;
  bool isEmailNotEmpty = false;
  bool isUsernameNotEmpty = false;
  bool isPasswordNotEmpty = false;
  bool isConfirmPassNotEmpty = false;
  String errorMsg = "";
  late TextEditingController _email;
  late TextEditingController _username;
  late TextEditingController _password;
  late TextEditingController _confirmPass;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _email = TextEditingController();
    _username = TextEditingController();
    _password = TextEditingController();
    _confirmPass = TextEditingController();

    _email.addListener(() {
      final isEmailNotEmpty = _email.text.isNotEmpty;
      setState(() {
        this.isEmailNotEmpty = isEmailNotEmpty;
      });
    });

    _username.addListener(() {
      final isUsernameNotEmpty = _username.text.isNotEmpty;
      setState(() {
        this.isUsernameNotEmpty = isUsernameNotEmpty;
      });
    });

    _password.addListener(() {
      final isPasswordNotEmpty = _password.text.isNotEmpty;
      setState(() {
        this.isPasswordNotEmpty = isPasswordNotEmpty;
      });
    });

    _confirmPass.addListener(() {
      final isConfirmPassNotEmpty = _confirmPass.text.isNotEmpty;
      setState(() {
        this.isConfirmPassNotEmpty = isConfirmPassNotEmpty;
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 81,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                margin: EdgeInsets.only(left: 18),
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
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
                margin: EdgeInsets.only(left: 41),
                child: const Text(
                  "Register",
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
                      hintText: "Enter Email",
                      fillColor: Colors.white10,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: _username,
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
                      hintText: "Create Username",
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
                        hintText: "Create Password",
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
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: _confirmPass,
                    obscureText: isHiddenConfirm,
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
                        hintText: "Confirm Password",
                        fillColor: Colors.white10,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isHiddenConfirm = !isHiddenConfirm;
                              });
                            },
                            child: isHiddenConfirm
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
                  isEmailNotEmpty &&
                          isUsernameNotEmpty &&
                          isPasswordNotEmpty &&
                          isConfirmPassNotEmpty
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
                              if (_password.text != _confirmPass.text) {
                                setState(() {
                                  errorMsg =
                                      "Password and confirm password doesn't match";
                                });
                              } else {
                                setState(() {
                                  errorMsg = "";
                                });
                                await postRegister(_email.text, _username.text,
                                    _password.text);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent),
                            child: const Center(
                              child: Text(
                                "Register",
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
                                "Register",
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
                        "Have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Login()));
                        },
                        child: const GradientText("Login here",
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

  Future<void> postRegister(
      String email, String username, String password) async {
    try {
      var response = await Dio().post('https://techtest.youapp.ai/api/register',
          data: {'email': email, 'username': username, 'password': password});

      _email.text = "";
      _username.text = "";
      _password.text = "";
      _confirmPass.text = "";

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Login()));
    } on DioException catch (e) {
      setState(() {
        errorMsg = e.response?.data["message"][0];
      });
    }
  }
}
