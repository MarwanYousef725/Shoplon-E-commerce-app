import 'package:ecommerce_app/Providers/cart_provider.dart';
import 'package:ecommerce_app/Providers/home_provider.dart';
import 'package:ecommerce_app/Providers/login_provider.dart';
import 'package:ecommerce_app/Providers/main_provider.dart';
import 'package:ecommerce_app/Providers/onboarding.dart';
import 'package:ecommerce_app/Providers/product_provider.dart';
import 'package:ecommerce_app/Providers/shop_provider.dart';
import 'package:ecommerce_app/Providers/signup_provider.dart';
import 'package:ecommerce_app/Providers/slider_provider.dart';
import 'package:ecommerce_app/Providers/switch_cartProvider.dart';
import 'package:ecommerce_app/Providers/switch_provider.dart';
import 'package:ecommerce_app/Providers/user_provider.dart';
import 'package:ecommerce_app/Providers/verificationprovider.dart';
import 'package:ecommerce_app/core/wraper.dart';
// import 'package:ecommerce_app/start_screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => VerificationProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SignupProvider()),
        ChangeNotifierProvider(create: (_) => SliderProvider()),
        ChangeNotifierProvider(create: (_) => SwitchProvider()),
        ChangeNotifierProvider(create: (_) => Onboarding()),
        ChangeNotifierProvider(create: (_) => ShopProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => Productpro()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => SwitchCartprovider()),
        ChangeNotifierProvider(create: (_) => productcartprovider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.white,
        brightness: Brightness.dark,
      ),
      themeMode: themeprovider.isDark ? ThemeMode.dark : ThemeMode.light,
      home: Wrapper(
        fun: () {
          themeprovider.ChangeStatues();
        },
      ),
    );
  }
}
