import 'package:ecommerce_app/forget_password_screens/set_new_password.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerificationCode extends StatefulWidget {
  const VerificationCode({super.key});

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  late TextEditingController verificationcode;
  final GlobalKey<FormState> formglobalkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    verificationcode = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    bool isdark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(bottom: 30),
              height: 300,
              child: Image.asset(
                isdark
                    ? 'assets/Illustration/VerificationCode_dark.png'
                    : 'assets/Illustration/image.png',
              ),
            ),
            Text(
              "Verification code",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 5),
            Container(
              child: Wrap(
                children: [
                  Text(
                    'We have send the code verication to ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    '+99******1233.',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Change phone number?',
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Form(
              key: formglobalkey,
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.number,
                controller: verificationcode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Requird';
                  } else {
                    return null;
                  }
                },
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus!.unfocus();
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.lightBlueAccent,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: Colors.grey.shade200,
                  prefixIcon: Icon(Icons.verified_outlined),
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIconColor: Colors.grey.shade600,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(height: 100),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Sended',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: const Color.fromARGB(
                            255,
                            124,
                            77,
                            255,
                          ),
                          elevation: 0,
                        ),
                      );
                    },
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.grey, width: 1),
                    ),
                    textColor: Colors.black,
                    color: Colors.white,
                    child: Text(
                      'Resend',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    onPressed: () {
                      if (formglobalkey.currentState!.validate()) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => SetNewPassword()),
                        );
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    textColor: Colors.white,
                    color: Colors.deepPurpleAccent,
                    child: Text(
                      'Next',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
