import 'package:ecommerce_app/start_screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  final VoidCallback fun;
  const Wrapper({super.key, required this.fun});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if ((snapshot.hasData || snapshot.data != null) &&
            FirebaseAuth.instance.currentUser!.emailVerified) {
          return SplashScreen(
            replacetheme: fun,
            logedin: true,
            email: snapshot.data!.email!,
          );
        } else {
          return SplashScreen(replacetheme: fun, logedin: false, email: null);
        }
      },
    );
  }
}
