import 'package:ecommerce_app/forget_password_screens/verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({super.key});

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  bool isloaded = false;
  late TextEditingController emaileditingcont;
  final GlobalKey<FormState> formglobalkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    emaileditingcont = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isloaded
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
              child: ListView(
                children: [
                  Text(
                    "Password recovery",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Enter your E-mail address to recovery your password',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 50),
                  Form(
                    key: formglobalkey,
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      controller: emaileditingcont,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Requird';
                        } else if (!value.contains('@')) {
                          return 'Email Must have @';
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
                        prefixIcon: Icon(Icons.email_outlined),
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        prefixIconColor: Colors.grey.shade600,
                        hintText: 'Email address',
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  MaterialButton(
                    color: Colors.deepPurpleAccent,
                    onPressed: () async {
                      if (formglobalkey.currentState!.validate()) {
                        setState(() {
                          isloaded = true;
                        });
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                          email: emaileditingcont.text.trim(),
                        );
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => Verification()),
                          (route) => false,
                        );
                        setState(() {
                          isloaded = false;
                        });
                      }
                    },
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
