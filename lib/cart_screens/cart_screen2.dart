import 'package:ecommerce_app/Providers/cart_provider.dart';
import 'package:ecommerce_app/cart_screens/order_confirmed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartScreen2 extends StatelessWidget {
  List orders;
  final double totalprice;
  CartScreen2({super.key, required this.orders, required this.totalprice});
  Widget paymentCard() {
    return Column(
      children: [
        SizedBox(height: 40),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(20),
            child: Image.asset('assets/images/Card1.png', fit: BoxFit.fill),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(20),
            child: Image.asset('assets/images/Card2.png', fit: BoxFit.fill),
          ),
        ),
      ],
    );
  }

  Widget paymentCash(context) {
    bool isdark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      spacing: 20,
      children: [
        SizedBox(height: 40),
        Container(
          height: 200,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(20),
            child: Image.asset(
              isdark
                  ? 'assets/Illustration/PayWithCash_darkTheme.png'
                  : 'assets/Illustration/PayWithCash_lightTheme.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Pay with Cash',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'A Shoplon refundable \$24.00 will be charged to use cash on delivery, if you want to save this amount please switch to Pay with Card.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget getSelectedScreen(int selectedindex, context) {
    switch (selectedindex) {
      case 0:
        return paymentCard();
      case 1:
        return paymentCash(context);
      default:
        return Center(
          child: const Text(
            "Please select a payment method",
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
        );
    }
  }

  List buttons = [
    {'icon': Icons.card_membership_outlined, 'text': 'Pay with card'},
    {'icon': Icons.payments_outlined, 'text': 'Pay with cash'},
  ];
  @override
  Widget build(BuildContext context) {
    final cartprovider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Payment method'), centerTitle: true),
      body: ListView(
        children: [
          SizedBox(height: 30),
          Container(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: buttons.length,
              itemBuilder: (context, i) {
                bool isSelected = cartprovider.selectedind == i;
                return Row(
                  children: [
                    SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        cartprovider.ChangeInd(i);
                      },
                      icon: Icon(
                        buttons[i]['icon'],
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                      label: Text(
                        buttons[i]['text'],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: isSelected
                            ? Colors.deepPurple
                            : Colors.white,
                        side: !isSelected
                            ? BorderSide(color: Colors.grey, width: 1.5)
                            : BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            height: 500,
            child: Center(
              child: getSelectedScreen(cartprovider.selectedind, context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
            child: MaterialButton(
              disabledColor: const Color.fromARGB(161, 124, 77, 255),
              padding: EdgeInsets.symmetric(vertical: 20),
              onPressed: cartprovider.isselected
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OrderConfirmed(
                            payway: buttons[cartprovider.selectedind]['text'],
                            totalprice: totalprice,
                          ),
                        ),
                      );
                    }
                  : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              textColor: Colors.white,
              color: Colors.deepPurpleAccent,
              child: Text(
                'Confirm',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
