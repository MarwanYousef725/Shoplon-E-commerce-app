// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Providers/onboarding.dart';
import 'package:ecommerce_app/start_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Page_View extends StatelessWidget {
  final VoidCallback replacetheme;
  Page_View({super.key, required this.replacetheme});

  PageController pageController = PageController();
  Color pagecolor = Colors.grey;
  List slider = [
    {
      'image1': 'assets/Illustration/Illustration-0.png',
      'image2': 'assets/Illustration/Illustration_darkTheme_0.png',
      'text1': 'Find the item you\'ve been looking for',
      'text2':
          'Here you\'ll see a rich variety of goods, carefully classified for a seamless browsing experience',
    },
    {
      'image1': 'assets/Illustration/Illustration-1.png',
      'image2': 'assets/Illustration/Illustration_darkTheme_1.png',
      'text1': 'Get those shopping bags filled',
      'text2':
          'Add any item you want to your cart, or save it to your wishlist, so you don\'t miss it in your future purchases',
    },
    {
      'image1': 'assets/Illustration/Illustration-2.png',
      'image2': 'assets/Illustration/Illustration_darkTheme_2.png',
      'text1': 'Find the item you\'ve been looking for',
      'text2':
          'Here you\'ll see a rich variety of goods, carefully classified for a seamless browsing experience',
    },
    {
      'image1': 'assets/Illustration/Illustration-3.png',
      'image2': 'assets/Illustration/Illustration_darkTheme_3.png',
      'text1': 'Package tracking',
      'text2':
          'In particular, Shoplon can pack your orders and help you seamlessly manage your shipments',
    },
    {
      'image1': 'assets/Illustration/Illustration-4.png',
      'image2': 'assets/Illustration/Illustration_darkTheme_4.png',
      'text1': 'Find the item you\'ve been looking for',
      'text2':
          'Here you\'ll see a rich variety of goods, carefully classified for a seamless browsing experience',
    },
  ];
  @override
  Widget build(BuildContext context) {
    bool isdark = Theme.of(context).brightness == Brightness.dark;
    final onboarding = Provider.of<Onboarding>(context);
    return Scaffold(
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {
            if (onboarding.selectedind == slider.length - 1) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => Login(replacetheme: replacetheme),
                ),
                (route) => false,
              );
            } else {
              pageController.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.linear,
              );
            }
          },
          backgroundColor: Colors.deepPurpleAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            // side: BorderSide( color: Colors.deepPurpleAccent),
          ),
          child: Icon(
            Icons.arrow_right_alt_outlined,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            width: 400,
            alignment: Alignment.centerRight,
            child: MaterialButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Login(replacetheme: replacetheme),
                  ),
                  (route) => false,
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text('skip', style: TextStyle(fontSize: 16)),
            ),
          ),
          Container(
            height: 600,
            child: PageView.builder(
              onPageChanged: (value) {
                onboarding.ChangeInd(value);
              },
              controller: pageController,
              itemCount: slider.length,
              itemBuilder: (context, i) {
                if (i.isEven) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      spacing: 100,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          isdark ? slider[i]['image2'] : slider[i]['image1'],
                          width: MediaQuery.sizeOf(context).width * .65,
                        ),
                        Column(
                          spacing: 15,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              child: Text(
                                slider[i]['text1'],
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                slider[i]['text2'],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      spacing: 100,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          spacing: 15,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              child: Text(
                                slider[i]['text1'],
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                slider[i]['text2'],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          isdark ? slider[i]['image2'] : slider[i]['image1'],
                          width: MediaQuery.sizeOf(context).width * .65,
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(slider.length, (i) {
              if (i == onboarding.selectedind) {
                return Container(
                  margin: EdgeInsets.only(left: 2),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                );
              } else {
                return Container(
                  margin: EdgeInsets.only(left: 2),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(50),
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
