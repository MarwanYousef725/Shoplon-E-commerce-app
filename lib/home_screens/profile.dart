import 'package:ecommerce_app/Providers/main_provider.dart';
import 'package:ecommerce_app/Providers/user_provider.dart';
import 'package:ecommerce_app/home_screens/preferences_screen.dart';
import 'package:ecommerce_app/home_screens/wallet_screen.dart';
import 'package:ecommerce_app/start_screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  final VoidCallback replacetheme;
  ProfileScreen({super.key, required this.email, required this.replacetheme});
  final email;

  final List account = [
    {'icon': Icons.list_alt_outlined, 'text': 'Orders', 'tap': false},
    {
      'icon': Icons.shopping_cart_checkout_outlined,
      'text': 'Returns',
      'tap': false,
    },
    {'icon': Icons.star_rounded, 'text': 'Orders', 'tap': false},
    {'icon': Icons.location_city_outlined, 'text': 'Addresses', 'tap': false},
    {'icon': Icons.payment_outlined, 'text': 'Payment', 'tap': false},
    {'icon': Icons.wallet, 'text': 'Wallet', 'tap': true},
  ];
  List personlay = [
    {
      'icon': Icons.notifications_none_outlined,
      'text': 'Notification',
      'tap': false,
    },
    {
      'icon': Icons.lightbulb_circle_outlined,
      'text': 'Preferences',
      'tap': true,
    },
  ];
  List settings = [
    {'icon': Icons.language_outlined, 'text': 'Language', 'tap': false},
    {'icon': Icons.location_on_outlined, 'text': 'Location', 'tap': false},
  ];
  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<UserProvider>(context);

    userprovider.loaduserinfo(email);
    return ListView(
      children: [
        ListTile(
          onTap: () {
            print('object');
          },
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              width: 60,
              height: 60,
              child: Image.asset(
                'assets/profile/profileimage.webp',
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            'Hi, ${(FirebaseAuth.instance.currentUser!.displayName != null) ? FirebaseAuth.instance.currentUser!.displayName : userprovider.userInfo.name}',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text("${FirebaseAuth.instance.currentUser!.email}"),
          trailing: Icon(Icons.arrow_forward_ios_rounded),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(20),
            child: Image.asset(
              'assets/product_images/Upgrade.jpg',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Lists(head: 'Account', tiles: account),
        Lists(head: 'Personalization', tiles: personlay),
        Lists(head: 'Settings', tiles: settings),
        ListTile(
          leading: Icon(Icons.mode_night),
          title: Text('Apperance'),
          trailing: Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return Switch(
                value: themeProvider.isDark,
                onChanged: (value) {
                  themeProvider.ChangeStatues();
                },
              );
            },
          ),
        ),
        Divider(),
        SizedBox(height: 30),
        ListTile(
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => Login(replacetheme: replacetheme),
              ),
              (route) => false,
            );
          },
          leading: Icon(Icons.logout_outlined, color: Colors.red),
          title: Text('Log Out'),
          textColor: Colors.red,
          titleTextStyle: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

class Lists extends StatelessWidget {
  final List tiles;
  final String head;
  const Lists({super.key, required this.tiles, required this.head});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Text(
            head,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
        Column(
          children: List.generate(tiles.length, (i) {
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    if (tiles[i]['text'] == 'Wallet') {
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (_) => WalletScreen()));
                    } else if (tiles[i]['text'] == 'Preferences') {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => PreferencesScreen()),
                      );
                    } else {
                      print('tap');
                    }
                  },
                  leading: Icon(tiles[i]['icon']),
                  title: Text(tiles[i]['text']),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
                Divider(),
              ],
            );
          }),
        ),
      ],
    );
  }
}
