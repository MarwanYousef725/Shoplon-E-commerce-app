import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Providers/product_provider.dart';
import 'package:ecommerce_app/Providers/switch_cartProvider.dart';
import 'package:ecommerce_app/core/product.dart';
import 'package:ecommerce_app/firebase/model_products.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Map data;
  const ProductDetails({super.key, required this.data});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isempty = true;
  int numberofproducts = 0;
  int index = 0;
  var snapshot;
  var productcartdata;
  Future getproductscart() async {
    snapshot = await FirebaseFirestore.instance
        .collection('cartProducts')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    productcartdata = snapshot.docs.map((doc) => doc.data()).toList();
    if (productcartdata.length > 0) {
      setState(() {
        isempty = false;
        for (int i = 0; i < productcartdata.length; i++) {
          if (productcartdata.asMap()[i]?['image'] == product.image) {
            numberofproducts++;
            index = i;
          }
        }
        if (numberofproducts == 0) {
          isempty = true;
        }
      });
      print("================================");
      // print();
      print("================================");
    }
    return false;
  }

  bool isloaded = false;
  PageController pageController = PageController();
  late Product product = Product(
    image: '',
    text1: '',
    text2: '',
    price: '',
    pricedis: '',
    productinfo: '',
    available: false,
    discount: '',
  );

  List images = [];
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  late String available;
  late Color color;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProductProvider>(context, listen: false);
      provider.loadProducts();
    });
    product = Product.fromJson(widget.data);
    if (product.available) {
      available = 'Available in stock';
      color = Colors.green;
    } else {
      available = 'Currently unavailable';
      color = Colors.red;
    }
    images = [
      product.image,
      'assets/product_images/product6.jpg',
      'assets/product_images/product5.jpg',
    ];
    getproductscart();
  }

  @override
  Widget build(BuildContext context) {
    final productpro = Provider.of<Productpro>(context);
    final switchprovider = Provider.of<SwitchCartprovider>(context);

    final productprovider = Provider.of<ProductProvider>(context);
    final products = productprovider.products;
    return Scaffold(
      appBar: AppBar(),
      body: isloaded
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                ListView(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 400,
                          child: PageView.builder(
                            onPageChanged: (value) {
                              productpro.ChangeInd(value);
                            },
                            controller: pageController,
                            itemCount: images.length,
                            itemBuilder: (context, i) {
                              if (i == 0) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: CachedNetworkImage(
                                      imageUrl: images[i],
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset(
                                      images[i],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 30,
                          right: 50,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 1,
                                  blurStyle: BlurStyle.outer,
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              spacing: 2,
                              children: List.generate(images.length, (i) {
                                if (i == productpro.selectedind) {
                                  return Container(
                                    margin: EdgeInsets.only(right: 2),
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    margin: EdgeInsets.only(right: 2),
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  );
                                }
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 25,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.text1,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(product.text2, style: TextStyle(fontSize: 25)),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  available,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber),
                                  Text('4.4'),
                                  Text(
                                    '(126 Reviews)',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Product Info',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            product.productinfo,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey, thickness: 1),
                    ListTile(
                      leading: Icon(Icons.inventory_2_outlined),
                      title: Text('Product Details'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(color: Colors.grey, thickness: 1),
                    ListTile(
                      leading: Icon(Icons.local_shipping_outlined),
                      title: Text('Shipping Information'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(color: Colors.grey, thickness: 1),
                    ListTile(
                      leading: Icon(Icons.shopping_cart_outlined),
                      title: Text('Returns'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(color: Colors.grey, thickness: 1),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '4.3',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Based on 128 Reviews',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber),
                                  Icon(Icons.star, color: Colors.amber),
                                  Icon(Icons.star, color: Colors.amber),
                                  Icon(Icons.star, color: Colors.amber),
                                  Icon(
                                    Icons.star_half_outlined,
                                    color: Colors.amber,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey, thickness: 1),
                    ListTile(
                      leading: Icon(Icons.message_rounded),
                      title: Text('Reviews'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(color: Colors.grey, thickness: 1),

                    ProductCard(
                      productinfo: products,
                      message: 'You may also like',
                      number: 6,
                    ),
                    SizedBox(height: 90),
                  ],
                ),
                if (product.available)
                  Positioned(
                    bottom: 10,
                    right: 25,
                    child: MaterialButton(
                      onPressed: isloaded
                          ? null
                          : !isempty
                          ? null
                          : () async {
                              setState(() {
                                isloaded = true;
                              });
                              await FirebaseFirestore.instance
                                  .collection('cartProducts')
                                  .add({
                                    "id":
                                        FirebaseAuth.instance.currentUser?.uid,
                                    "image": widget.data['image'],
                                    "text1": widget.data['text1'],
                                    "text2": widget.data['text2'],
                                    "price": widget.data['price'],
                                    "pricedis": widget.data['pricedis'],
                                    "productinfo": widget.data['productinfo'],
                                    "available": widget.data['available'],
                                    "discount": widget.data['discount'],
                                  });
                              setState(() {
                                isloaded = false;
                              });
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ProductDetails(data: widget.data),
                                ),
                              );
                            },
                      child: Container(
                        padding: EdgeInsets.only(left: 30),
                        width: 300,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: isloaded
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        product.price,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        'Unit price',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 70,
                                    width: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: !isempty
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    numberofproducts++;
                                                    isloaded = true;
                                                  });
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                        'cartProducts',
                                                      )
                                                      .add({
                                                        "id": FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            ?.uid,
                                                        "image": widget
                                                            .data['image'],
                                                        "text1": widget
                                                            .data['text1'],
                                                        "text2": widget
                                                            .data['text2'],
                                                        "price": widget
                                                            .data['price'],
                                                        "pricedis": widget
                                                            .data['pricedis'],
                                                        "productinfo": widget
                                                            .data['productinfo'],
                                                        "available": widget
                                                            .data['available'],
                                                        "discount": widget
                                                            .data['discount'],
                                                      });
                                                  setState(() {
                                                    isloaded = false;
                                                  });
                                                  Navigator.of(
                                                    context,
                                                  ).pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          ProductDetails(
                                                            data: widget.data,
                                                          ),
                                                    ),
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  size: 25,
                                                ),
                                              ),
                                              Text(
                                                '$numberofproducts',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    numberofproducts--;
                                                    isloaded = true;
                                                  });
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                        "cartProducts",
                                                      )
                                                      .doc(
                                                        snapshot.docs[index].id,
                                                      )
                                                      .delete();
                                                  setState(() {
                                                    isloaded = false;
                                                  });
                                                  setState(() {});
                                                  Navigator.of(
                                                    context,
                                                  ).pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          ProductDetails(
                                                            data: widget.data,
                                                          ),
                                                    ),
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  size: 25,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Text(
                                            'Add to cart',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                if (!product.available)
                  Positioned(
                    bottom: 10,
                    right: 40,
                    child: Container(
                      alignment: Alignment.center,
                      width: 300,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: SwitchListTile(
                        value: switchprovider.turn,
                        onChanged: (value) {
                          switchprovider.turn = value;
                        },
                        title: Text(
                          'Notify when product back to stock',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
