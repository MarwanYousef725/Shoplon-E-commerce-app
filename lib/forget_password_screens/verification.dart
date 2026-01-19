import 'package:ecommerce_app/start_screens/login.dart';
import 'package:flutter/material.dart';

class Verification extends StatelessWidget {
  const Verification({super.key});
  @override
  Widget build(BuildContext context) {
    bool isdark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            SizedBox(height: 30),
            Center(
              child: Column(
                spacing: 30,
                children: [
                  (isdark)
                      ? Image.asset("assets/Illustration/Password_dark.png")
                      : Image.asset('assets/Illustration/Password.png'),
                  Text(
                    'A link has been sent to your email in the spam folder. To do new password',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            MaterialButton(
              padding: EdgeInsets.all(20),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => Login(replacetheme: () {})),
                  (route) => false,
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              textColor: Colors.white,
              color: Colors.deepPurpleAccent,
              child: Text(
                'Login',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
