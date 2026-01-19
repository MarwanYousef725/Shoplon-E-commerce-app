import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/cart_screens/receipt.dart';
import 'package:ecommerce_app/core/product_details.dart';
import 'package:ecommerce_app/firebase/model_products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderConfirmed extends StatefulWidget {
  final String payway;
  final totalprice;
  const OrderConfirmed({
    super.key,
    required this.payway,
    required this.totalprice,
  });

  @override
  State<OrderConfirmed> createState() => _OrderConfirmedState();
}

class _OrderConfirmedState extends State<OrderConfirmed> {
  @override
  Widget build(BuildContext context) {
    bool isdark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: Text('Order'), centerTitle: true),
      body: ListView(
        children: [
          // SizedBox(height: 40),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ProductCards2(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Order detail',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Amount paid',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              '\$${(widget.payway.contains("cash")) ? (widget.totalprice + 25 + 50) : (widget.totalprice + 50)}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                              ),
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
                              'Order price',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              '\$${(widget.totalprice)}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                              ),
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
                              'VAT',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              '\$50',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      (widget.payway.contains("cash"))
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Cash on delivery fees',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '\$24',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Cash on delivery fees',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '\$0',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
            child: MaterialButton(
              disabledColor: const Color.fromARGB(161, 124, 77, 255),
              padding: EdgeInsets.symmetric(vertical: 20),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => Receipt(
                      payway: widget.payway,
                      totalprice: widget.totalprice,
                      isdark: isdark,
                      orders: _ProductCardsState().orderdproducts,
                    ),
                  ),
                  (predicate) => false,
                );
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Order Confirmed')));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              textColor: Colors.white,
              color: Colors.deepPurpleAccent,
              child: Text(
                'Order confirmation',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCards2 extends StatefulWidget {
  // final List products;
  const ProductCards2({
    super.key,
    // required this.products,
  });

  @override
  State<ProductCards2> createState() => _ProductCardsState();
}

class _ProductCardsState extends State<ProductCards2> {
  bool isempty = true;
  int numberofproducts = 0;
  int count = 0;
  int index = 0;
  var snapshot;
  var productcartdata;
  Map orderdproducts = {};
  Map secondorderdproducts = {};
  final result = <dynamic, Map<dynamic, dynamic>>{};
  final result2 = <dynamic, Map<dynamic, dynamic>>{};
  Future getproductscart() async {
    String previmage = '';
    orderdproducts.removeWhere((key, value) => value["image"] == previmage);
    snapshot = await FirebaseFirestore.instance
        .collection('cartProducts')
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
    return Column(
      children: [
        Column(
          children: List.generate(result2.length, (i) {
            int itemcount = 0;
            for (int j = 0; j < result.length; j++) {
              if (result2.values.elementAt(i)["image"] ==
                  result.values.elementAt(j)['image']) {
                setState(() {
                  itemcount = result.values.elementAt(j)["count"];
                });
              }
            }
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
            return Container(
              margin: EdgeInsets.only(top: 10),
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
                          child: CachedNetworkImage(
                            imageUrl: product.image,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            fit: BoxFit.cover,
                            width: MediaQuery.sizeOf(context).width * .30,
                            height: MediaQuery.sizeOf(context).width * .25,
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      Container(
                        // width: 130,
                        height: MediaQuery.sizeOf(context).height * .115,
                        child: Column(
                          spacing: 2,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
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
                            Text(
                              "amount: ×$itemcount",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (product.discount != null)
                    Positioned(
                      top: 10,
                      left: 50,
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
            );
          }),
        ),
        // SizedBox(height: 10),
      ],
    );
  }
}
