// import 'package:ecommerce_app/core/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Providers/cart_provider.dart';
// import 'package:ecommerce_app/Providers/product_provider.dart';
import 'package:ecommerce_app/cart_screens/cart_screen1.dart';
import 'package:ecommerce_app/core/product_details.dart';
import 'package:ecommerce_app/firebase/model_products.dart';
import 'package:ecommerce_app/home_screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool isempty = true;
  int numberofproducts = 0;
  int index = 0;
  var snapshot;
  var productcartdata;
  Future getproductscart() async {
    snapshot = await FirebaseFirestore.instance
        .collection("cartProducts")
        .get();
    productcartdata = snapshot.docs.map((doc) => doc.data()).toList();
    if (productcartdata.length > 0) {
      setState(() {
        isempty = false;
        for (int i = 0; i < productcartdata.length; i++) {
          if (productcartdata.asMap()[i]?['image'] == products2[i].image) {
            numberofproducts++;
            index = i;
          }
        }
        if (numberofproducts == 0) {
          isempty = true;
        }
      });
    }
  }

  List products2 = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<productcartprovider>(context, listen: false);
      provider.loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productprovider = Provider.of<productcartprovider>(context);
    final products = productprovider.products;
    if (products.length > 2) {
      products2 = products;
    }
    return Scaffold(
      appBar: AppBar(title: Text('Wallet')),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.deepPurple,
            ),
            child: Column(
              spacing: 10,
              children: [
                Text(
                  'Your current balance',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  '\$384.90',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                SizedBox(height: 15),
                MaterialButton(
                  onPressed: () {},
                  padding: EdgeInsets.symmetric(vertical: 20),
                  minWidth: 1000,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  color: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  child: Text(
                    '+ Charge Balance',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Wallet history',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          ProductCards(products: products2, purchase: true, title: 'Purchase'),
          ProductCards(products: products2, purchase: false, title: 'Return'),
          ProductCards(products: products2, purchase: true, title: 'Purchase'),
          ProductCards(products: products2, purchase: true, title: 'Purchase'),
        ],
      ),
    );
  }
}

class ProductCards extends StatefulWidget {
  final String title;
  final bool purchase;
  final List products;
  const ProductCards({
    super.key,
    required this.title,
    required this.purchase,
    required this.products,
  });

  @override
  State<ProductCards> createState() => _ProductCardsState();
}

class _ProductCardsState extends State<ProductCards> {
  bool isempty = true;
  int numberofproducts = 0;
  int count = 0;
  int index = 0;
  var snapshot;
  var productcartdata;
  Map orderdproducts = {};
  Map secondorderdproducts = {};
  // Map prod = {};
  final result = <dynamic, Map<dynamic, dynamic>>{};
  final result2 = <dynamic, Map<dynamic, dynamic>>{};
  Future getproductscart() async {
    String previmage = '';
    orderdproducts.removeWhere((key, value) => value["image"] == previmage);
    snapshot = await FirebaseFirestore.instance
        .collection("cartProducts")
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    productcartdata = snapshot.docs.map((doc) => doc.data()).toList();
    if (productcartdata.length > 0) {
      setState(() {
        isempty = false;
        for (int i = 0; i < productcartdata.length; i++) {
          orderdproducts[i] = productcartdata.asMap()[i];
          index = i;
        }
        for (int i = 0; i < orderdproducts.length; i++) {
          previmage = productcartdata.asMap()[i]['image'];
          for (int j = 0; j < orderdproducts.length; j++) {
            if (orderdproducts[i]['image'] == orderdproducts[j]['image']) {
              count++;
            }
          }
          secondorderdproducts[i] = {
            'image': orderdproducts[i]['image'],
            'index': i,
            "count": count,
          };
          count = 0;
          previmage = "";
        }
        if (numberofproducts == 0) {
          isempty = true;
        }
        final seenValues = <String>{};
        secondorderdproducts.forEach((key, value) {
          if (seenValues.add(value['image'] as String)) {
            result[key] = value;
          }
        });
        final seenValues2 = <String>{};
        orderdproducts.forEach((key, value) {
          if (seenValues2.add(value['image'] as String)) {
            result2[key] = value;
          }
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getproductscart();
  }

  bool isloaded = false;
  @override
  Widget build(BuildContext context) {
    // return SizedBox();
    // getproductscart();
    print("================================");
    print(result2.length);
    print("================================");
    print("================================");
    print(result2);
    print("================================");
    // return SizedBox();
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Column(
            children: List.generate(result2.length, (i) {
              result2.values.elementAt(i)['image'];
              Map map = {
                "image": result2.values.elementAt(i)['image'],
                'text1': result2.values.elementAt(i)['text1'],
                'text2': result2.values.elementAt(i)['text2'],
                'price': result2.values.elementAt(i)['price'],
                'pricedis': result2.values.elementAt(i)['pricedis'],
                'productinfo': result2.values.elementAt(i)['productinfo'],
                'discount': result2.values.elementAt(i)['discount'],
                'available': result2.values.elementAt(i)['available'],
              };
              Product product = Product.fromJson(result2.values.elementAt(i));
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProductDetails(data: map),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Stack(
                    children: [
                      Row(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 120,
                              width: 100,
                              child: CachedNetworkImage(
                                imageUrl: product.image,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                fit: BoxFit.cover,
                                width: 200,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                          Container(
                            width: 130,
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  result2.values.elementAt(i)['text1'],
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                                Text(
                                  result2.values.elementAt(i)['text2'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Row(
                                  spacing: 5,
                                  children: [
                                    Text(
                                      result2.values.elementAt(i)['price'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.lightBlue,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      result2.values.elementAt(i)['pricedis'],
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 10,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        setState(() {
                                          // numberofproducts++;
                                          isloaded = true;
                                        });
                                        await FirebaseFirestore.instance
                                            .collection('cartProducts')
                                            .add({
                                              "id": FirebaseAuth
                                                  .instance
                                                  .currentUser
                                                  ?.uid,
                                              "image": result2[i]?['image'],
                                              "text1": result2[i]?['text1'],
                                              "text2": result2[i]?['text2'],
                                              "price": result2[i]?['price'],
                                              "pricedis":
                                                  result2[i]?['pricedis'],
                                              "productinfo":
                                                  result2[i]?['productinfo'],
                                              "available":
                                                  result2[i]?['available'],
                                              "discount":
                                                  result2[i]?['discount'],
                                            });
                                        setState(() {
                                          isloaded = false;
                                        });
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (_) => HomeScreen(
                                              emailkey: '',
                                              replacetheme: () {},
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        // color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        size: 25,
                                      ),
                                    ),
                                    Text(
                                      '${result.values.elementAt(i)['count']}',
                                      style: TextStyle(
                                        // color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        setState(() {
                                          // numberofproducts--;
                                          isloaded = true;
                                        });
                                        await FirebaseFirestore.instance
                                            .collection("cartProducts")
                                            .doc(
                                              snapshot
                                                  .docs[secondorderdproducts[i]['index']]
                                                  .id,
                                            )
                                            .delete();
                                        setState(() {
                                          isloaded = false;
                                        });
                                        setState(() {});
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (_) => HomeScreen(
                                              emailkey: '',
                                              replacetheme: () {},
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.remove,
                                        // color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        size: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (product.discount != null)
                        Positioned(
                          top: 10,
                          left: 40,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              product.discount ?? '',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
          // SizedBox(height: 10),
        ],
      ),
    );
  }
}
