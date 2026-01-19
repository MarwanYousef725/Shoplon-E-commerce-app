import 'package:ecommerce_app/home_screens/onsale_products.dart';
import 'package:flutter/material.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: ListView(
        children: [
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: 'Find something...',
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(Icons.tune_outlined),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Categories',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          SizedBox(height: 10),
          ExpansionTile(
            leading: const Icon(Icons.point_of_sale_outlined),
            title: const Text('On Sale'),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 10),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('All Clothing'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OnsaleProductsScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('New In'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OnsaleProductsScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('Coats & Jackets'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OnsaleProductsScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('Dresses'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OnsaleProductsScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('Jeans'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OnsaleProductsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('Man\'s & Woman\'s'),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 10),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('All Clothing'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OnsaleProductsScreen(),
                          ),
                        );
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: Text('New In'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OnsaleProductsScreen(),
                          ),
                        );
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Coats & Jackets'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OnsaleProductsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: Icon(Icons.child_friendly_outlined),
            title: Text('Kids'),
            children: [
              Padding(
                padding: EdgeInsets.only(left: 50, top: 10),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('All Clothing'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OnsaleProductsScreen(),
                          ),
                        );
                      },
                    ),
                    Divider(),
                    ListTile(title: Text('New In')),
                    Divider(),
                    ListTile(title: Text('Coats & Jackets')),
                  ],
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: Icon(Icons.watch_outlined),
            title: Text('Accessories'),
            children: [
              Padding(
                padding: EdgeInsets.only(left: 50, top: 10),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('All Clothing'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OnsaleProductsScreen(),
                          ),
                        );
                      },
                    ),
                    Divider(),
                    ListTile(title: Text('New In')),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
