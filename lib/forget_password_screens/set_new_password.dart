import 'package:ecommerce_app/start_screens/login.dart';
import 'package:flutter/material.dart';

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({super.key});

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  late TextEditingController newpasswordeditingcont;
  late TextEditingController newpasswordagaineditingcont;
  final GlobalKey<FormState> formglobalkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    newpasswordeditingcont = TextEditingController();
    newpasswordagaineditingcont = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        child: ListView(
          children: [
            Text(
              "Set new password",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 5),
            Text(
              'Your new password must be diffrent from previosly used passwords.',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 50),
            Form(
              key: formglobalkey,
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: newpasswordeditingcont,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Requird';
                      } else if (value.length < 6) {
                        return 'Password must more than 6 characters';
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
                      hintText: 'New password',
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: newpasswordagaineditingcont,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Requird';
                      } else if (value.length < 6) {
                        return 'Password must more than 6 characters';
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
                      hintText: 'New password again',
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 120),
            MaterialButton(
              padding: EdgeInsets.symmetric(vertical: 20),
              onPressed: () {
                if (formglobalkey.currentState!.validate()) {
                  if (newpasswordeditingcont.value ==
                      newpasswordagaineditingcont.value) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Login(replacetheme: () => ''),
                      ),
                      (route) => false,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        elevation: 0,
                        content: Text(
                          'Password not Equal',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.deepPurpleAccent,
                      ),
                    );
                  }
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              textColor: Colors.white,
              color: Colors.deepPurpleAccent,
              child: Text(
                'Change password',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
