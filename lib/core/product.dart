import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/product_details.dart';
import 'package:ecommerce_app/firebase/model_products.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  final List productinfo;
  final String message;
  late int number;
  final bool isrow;
  ProductCard({
    super.key,
    required this.productinfo,
    required this.message,
    this.isrow = false,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    if (number > productinfo.length) {
      number = productinfo.length;
    }
    if (!isrow) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message != '')
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: Text(
                message,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
          Container(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: number,
              itemBuilder: (context, i) {
                Product product = Product.fromJson(productinfo[i]);
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProductDetails(data: productinfo[i]),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 150,
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
                        Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 120,
                                width: 200,
                                child: CachedNetworkImage(
                                  imageUrl: product.image,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  fit: BoxFit.cover,
                                  width: 200,
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                // Image.network(
                                //   // productinfo[i]['image'],
                                //   product.image,
                                //   fit: BoxFit.cover,
                                //   // cacheHeight: 100,
                                //   cacheWidth: 200,
                                // ),
                              ),
                            ),
                            Text(
                              // productinfo[i]['text1'],
                              product.text1,
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Text(
                              // productinfo[i]['text2'],
                              product.text2,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Row(
                              spacing: 5,
                              children: [
                                Text(
                                  // productinfo[i]['price'],
                                  product.price,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.lightBlue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  // productinfo[i]['pricedis'],
                                  product.pricedis,
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 10,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (product.discount != null)
                          Positioned(
                            top: 10,
                            right: 10,
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
                                // productinfo[i]['discount'],
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
              },
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message != '')
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: Text(
                message,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
          Container(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: number,
              itemBuilder: (context, i) {
                Product product = Product.fromJson(productinfo[i]);
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProductDetails(data: productinfo[i]),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 280,
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
                                width: 120,
                                child: CachedNetworkImage(
                                  imageUrl: product.image,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.cover,
                                  width: 120,
                                ),
                                //                                 Image.network(
                                //                                   // productinfo[i]['image'],
                                //                                   product.image,
                                //                                   fit: BoxFit.cover,
                                //                                   // cacheHeight: 120,
                                //                                   cacheWidth: 120,
                                //                                 ),
                              ),
                            ),
                            Container(
                              width: 130,
                              child: Column(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // productinfo[i]['text1'],
                                    product.text1,
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                  Text(
                                    // productinfo[i]['text2'],
                                    product.text2,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Row(
                                    spacing: 5,
                                    children: [
                                      Text(
                                        // productinfo[i]['price'],
                                        product.price,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.lightBlue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        // productinfo[i]['pricedis'],
                                        product.pricedis,
                                        style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 10,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
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
                            left: 60,
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
                                // productinfo[i]['discount'],
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
              },
            ),
          ),
        ],
      );
    }
  }
}
