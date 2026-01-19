import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Providers/home_provider.dart';
import 'package:ecommerce_app/cart_screens/cart_screen1.dart';
import 'package:ecommerce_app/home_screens/bookmark.dart';
import 'package:ecommerce_app/home_screens/discovery.dart';
import 'package:ecommerce_app/home_screens/profile.dart';
import 'package:ecommerce_app/home_screens/shop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback replacetheme;
  const HomeScreen({
    super.key,
    required this.emailkey,
    required this.replacetheme,
    // this.snapshot
  });
  final emailkey;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeprvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: homeprvider.selectedind,
        onTap: (value) {
          if (value == 3) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => HomeScreen(
                  emailkey: widget.emailkey,
                  replacetheme: widget.replacetheme,
                ),
              ),
            );
          }
          homeprvider.ChangeInd(value);
        },
        selectedItemColor: Colors.deepPurpleAccent,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.black,
        unselectedIconTheme: IconThemeData(
          color: Colors.grey,
          size: 24,
          opacity: 0.9,
        ),
        selectedIconTheme: IconThemeData(
          color: Colors.deepPurpleAccent,
          size: 24,
          opacity: 0.9,
        ),
        selectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_add_outlined),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('cartProducts')
                  .where(
                    'id',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                final itemcount = snapshot.data?.size ?? 0;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_outlined),
                    if (itemcount > 0)
                      Text(
                        "${itemcount}",
                        style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                  ],
                );
              },
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text(
          'Shoplon',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: IndexedStack(
        index: homeprvider.selectedind,
        children: [
          const ShopScreen(),
          const DiscoveryScreen(),
          const BookMarkScreen(),
          const CartScreen1(),
          ProfileScreen(
            email: widget.emailkey,
            replacetheme: widget.replacetheme,
          ),
        ],
      ),
    );
  }
}
