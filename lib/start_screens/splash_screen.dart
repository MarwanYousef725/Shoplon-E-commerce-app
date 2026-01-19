import 'package:ecommerce_app/home_screens/home.dart';
import 'package:ecommerce_app/start_screens/pageview.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback replacetheme;
  final bool logedin;
  final String? email;
  const SplashScreen({
    super.key,
    required this.replacetheme,
    required this.logedin,
    required this.email,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (!mounted) return;
      if (widget.logedin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(
              replacetheme: widget.replacetheme,
              emailkey: widget.email,
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => Page_View(replacetheme: widget.replacetheme),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/logo/background.jpg'),
        ),
      ),
      child: Center(child: Image.asset('assets/logo/logo.png')),
    );
  }
}
