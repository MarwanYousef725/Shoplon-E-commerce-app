import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Providers/cart_provider.dart';
import 'package:ecommerce_app/Providers/product_provider.dart';
import 'package:ecommerce_app/cart_screens/cart_screen2.dart';
import 'package:ecommerce_app/firebase/model_products.dart';
import 'package:ecommerce_app/home_screens/discovery.dart';
import 'package:ecommerce_app/home_screens/wallet_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen1 extends StatefulWidget {
  const CartScreen1({super.key});

  @override
  State<CartScreen1> createState() => _CartScreen1State();
}

class _CartScreen1State extends State<CartScreen1> {
  bool isempty = true;
  int numberofproducts = 0;
  int index = 0;
  var snapshot;
  var productcartdata;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<productcartprovider>(context, listen: false);
      provider.loadProducts();
    });
  }

  String sumprices(l) {
    double price = 0;
    for (int i = 0; i < l.length; i++) {
      Product product = Product.fromJson(l[i]);
      try {
        price += double.parse(product.price.replaceAll('\$', ''));
      } catch (e) {
        print('Error is $e');
      }
    }
    return price.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final itemsStream = FirebaseFirestore.instance
        .collection('cartProducts')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: itemsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error!'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final documents = snapshot.data!.docs;
          print("=======================================");
          print(documents.toList());
          print("=======================================");
          return ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // spacing: 20,
                  children: [
                    Text('Office', style: TextStyle(fontSize: 20)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Text(
                                'Rio Nowakowska, Zabiniec 12/222, 31-215 Cracow, Poland',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '+79 123 456 789',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.location_on_outlined,
                          size: 100,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Review your order',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 20),
              ProductCards(
                title: '',
                purchase: true,
                products: documents.toList(),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  enabled: (double.parse(sumprices(documents.toList())) != 0),
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Type coupon code',
                    prefixIcon: Icon(Icons.local_activity_outlined),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              (double.parse(sumprices(documents.toList())) != 0)
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        spacing: 20,
                        children: [
                          SizedBox(height: 20),
                          Text('Order Summary', style: TextStyle(fontSize: 20)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Subtotal',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  '\$${sumprices(documents.toList())}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Shipping Fee',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  'Free',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total (included of VAT)',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  '\$${double.parse(sumprices(documents.toList())) + 50}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Estimated VAT',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text('\$50', style: TextStyle(fontSize: 18)),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),

                      // SizedBox(height: 20),
                    )
                  : Center(
                      child: Text(
                        "Cart is Empty",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

              SizedBox(height: 20),
              (double.parse(sumprices(documents.toList())) != 0)
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: MaterialButton(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CartScreen2(
                                orders: documents.toList(),
                                totalprice: double.parse(
                                  sumprices(documents.toList()),
                                ),
                              ),
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        textColor: Colors.white,
                        color: Colors.deepPurpleAccent,
                        child: Text(
                          'Checkout',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    )
                  : SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
