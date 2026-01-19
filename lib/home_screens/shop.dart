import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Providers/product_provider.dart';
import 'package:ecommerce_app/Providers/shop_provider.dart';
import 'package:ecommerce_app/Providers/slider_provider.dart';
import 'package:ecommerce_app/core/product.dart';
import 'package:ecommerce_app/firebase/model_sliders.dart';
import 'package:ecommerce_app/home_screens/onsale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});
  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  PageController pageController = PageController();
  late Sliders slider = Sliders(image: '', text1: '', text2: '', text3: '');
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProductProvider>(context, listen: false);
      provider.loadProducts();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<SliderProvider>(context, listen: false);
      provider.loadSlider();
    });
  }

  List buttons = [
    {'icon': '', 'text': 'All Categories'},
    {'icon': Icons.point_of_sale_outlined, 'text': 'On Sale'},
    {'icon': Icons.man_4_outlined, 'text': 'Man\'s'},
    {'icon': Icons.woman_outlined, 'text': 'Woman\'s'},
    {'icon': Icons.child_friendly_outlined, 'text': 'Kids'},
  ];
  @override
  Widget build(BuildContext context) {
    bool isdark = Theme.of(context).brightness == Brightness.dark;
    final shopprovider = Provider.of<ShopProvider>(context);
    final productprovider = Provider.of<ProductProvider>(context);
    final products = productprovider.products;
    final sliderprovider = Provider.of<SliderProvider>(context);
    final sliders = sliderprovider.products;

    return ListView(
      children: [
        Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => OnsaleScreen()),
                );
              },
              child: Container(
                height: 200,
                child: PageView.builder(
                  onPageChanged: (value) {
                    shopprovider.ChangeInd(value);
                  },
                  controller: pageController,
                  itemCount: sliders.length,
                  itemBuilder: (context, i) {
                    slider = Sliders.fromJson(sliders[i]);
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(slider.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.only(left: 20),
                        color: const Color.fromARGB(100, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              slider.text1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              slider.text2,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 30),
                            Text(
                              slider.text3,
                              style: TextStyle(
                                color: Colors.black,
                                backgroundColor: Colors.grey.shade400,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(sliders.length, (i) {
                  if (i == shopprovider.selectedind) {
                    return Container(
                      margin: EdgeInsets.only(right: 2),
                      width: 6,
                      height: 15,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    );
                  } else {
                    return Container(
                      margin: EdgeInsets.only(right: 2),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, bottom: 20),
          child: Text(
            'Categories',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20),
          height: 60,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: List.generate(buttons.length, (i) {
                  if (i == 0) {
                    return MaterialButton(
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: Colors.deepPurpleAccent,
                      textColor: Colors.white,
                      onPressed: () {},
                      child: Text(
                        buttons[i]['text'],
                        style: TextStyle(fontSize: 12),
                      ),
                    );
                  } else {
                    return MaterialButton(
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.grey, width: 1),
                      ),
                      textColor: isdark ? Colors.white : Colors.black,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => OnsaleScreen()),
                        );
                      },
                      child: Row(
                        spacing: 10,
                        children: [
                          Icon(buttons[i]['icon'], size: 20),
                          Text(
                            buttons[i]['text'],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
        ProductCard(
          productinfo: products,
          message: 'Popular products',
          number: 6,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => OnsaleScreen()),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  "https://i.postimg.cc/0yT7rgxX/pageviewpic1.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: const Color.fromARGB(130, 0, 0, 0),
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Super Flash Sale',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '50% Off',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ProductCard(productinfo: products, message: 'Flash sale', number: 3),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => OnsaleScreen()),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  "https://i.postimg.cc/8PW63KLh/pageviewpic3.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: const Color.fromARGB(130, 0, 0, 0),
              padding: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NEW',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'ARRIVAL',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'SPECIAL OFFER',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ProductCard(productinfo: products, message: 'Best sellers', number: 3),
        SizedBox(height: 20),
        ProductCard(
          productinfo: products,
          message: 'Most popular',
          isrow: true,
          number: 6,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => OnsaleScreen()),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  "https://i.postimg.cc/43cn0nDB/pageviewpic2.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: const Color.fromARGB(130, 0, 0, 0),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    color: Colors.grey,
                    child: Text(
                      '50% Off',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    'BLACK',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'FRIDAY',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'COLLECTION',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ProductCard(productinfo: products, message: 'Best sellers', number: 3),
      ],
    );
  }
}
