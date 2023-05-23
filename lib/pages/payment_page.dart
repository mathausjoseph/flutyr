import 'package:flutter/material.dart';

class PayementPage extends StatelessWidget {
  const PayementPage({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Payment Page"))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                
              ),
              child: InkWell(
                onTap: () {
                  // Action when monCash card is tapped
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset("assets/moncash.png", height: 40),
                      const SizedBox(width: 10),
                      const Text("Payment with monCash"),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () {
                  // Action when paypal card is tapped
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset("assets/paypall.png", height: 40),
                      const SizedBox(width: 10),
                      const Text("Payment with PayPal"),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () {
                  // Action when mastercard card is tapped
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset("assets/mastercard.png", height: 40),
                      const SizedBox(width: 10),
                      const Text("Payment with Mastercard",),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}