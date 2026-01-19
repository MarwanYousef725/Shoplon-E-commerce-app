import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Providers/product_provider.dart';
import 'package:ecommerce_app/core/product_details.dart';
import 'package:ecommerce_app/firebase/model_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnsaleProductsScreen extends StatefulWidget {
  const OnsaleProductsScreen({super.key});

  @override
  State<OnsaleProductsScreen> createState() => _OnsaleProductsScreenState();
}

class _OnsaleProductsScreenState extends State<OnsaleProductsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProductProvider>(context, listen: false);
      provider.loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productprovider = Provider.of<ProductProvider>(context);
    final products = productprovider.products;
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        padding: EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: .55,
        ),
        itemCount: products.length,
        itemBuilder: (context, i) {
          Product product = Product.fromJson(products[i]);
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProductDetails(data: products[i]),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 150,
                          width: 200,
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
                      Text(
                        product.text1,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      Text(
                        product.text2,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        spacing: 5,
                        children: [
                          Text(
                            product.price,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            product.pricedis,
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 14,
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
                          product.discount ?? '',
                          style: TextStyle(
                            fontSize: 12,
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
    );
  }
}
