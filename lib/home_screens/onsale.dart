import 'package:ecommerce_app/Providers/product_provider.dart';
import 'package:ecommerce_app/core/product.dart';
import 'package:ecommerce_app/home_screens/onsale_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnsaleScreen extends StatefulWidget {
  const OnsaleScreen({super.key});

  @override
  State<OnsaleScreen> createState() => _OnsaleScreenState();
}

class _OnsaleScreenState extends State<OnsaleScreen> {
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
      appBar: AppBar(title: Text('On sale'), centerTitle: true),
      body: Container(
        child: ListView(
          children: [
            Column(
              children: List.generate(4, (i) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => OnsaleProductsScreen()),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.5),
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.grey.shade100,
                    ),
                    height: 300,
                    width: 350,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Image.asset(
                        'assets/on_sale/onsale${i + 1}.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            Divider(),
            ProductCard(
              productinfo: products,
              message: '',
              number: products.length,
            ),
            SizedBox(height: 40),
            Divider(),
            ProductCard(
              productinfo: products,
              message: '',
              number: products.length,
              isrow: true,
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
