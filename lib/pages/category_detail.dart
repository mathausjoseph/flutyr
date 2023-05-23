import 'package:flutter/material.dart';
import '/pages/payment_page.dart';
import '/_widget/_widget_product.dart';
import '/service/api_service.dart';

class CategoryDetail extends StatelessWidget {
  final String category;
  const CategoryDetail({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category),
      actions: [
          TextButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const PayementPage()));
          }, child: const Text("PEYE", style: TextStyle(
          fontSize: 22,
          color: Colors.white 
        ), ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(category, style:TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    // color:Colors.blue,
  )),
          ),
          ProductListWidget(getProducts: () {
            return APIService.getProductsByCategory(category);
          }),
        ],
        )
      ),
    );
  }
}