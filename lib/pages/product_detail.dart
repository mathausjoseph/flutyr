import 'package:flutter/material.dart';
import '/utils.dart';
import 'package:provider/provider.dart';
import '/storage/storage.dart';
import '/_models/article.dart';

class ProductDetail extends StatefulWidget {
  final Article article;
  final int userId;
  const ProductDetail({Key? key, required this.article, required this.userId}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}


class _ProductDetailState extends State<ProductDetail> {

  late Future<bool> isCart;

  @override
  void initState() {
    super.initState();
    isCart = Storage.isCartInProduct(widget.userId, widget.article.id);
  }


  addButton() async{
    print('userId ${widget.userId}');
    print('productId ${widget.article.id}');
    if (widget.userId == null || widget.userId <=-1) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("You must connected to add to shop")));
    }else if(widget.userId.isFinite) {
      await Storage.toggleCartsProduct(widget.userId, widget.article.id);
      setState(() {
        isCart = Storage.isCartInProduct(widget.userId, widget.article.id);
      });
    }
  }
    

  @override
  Widget build(BuildContext context) {
    StateNotifier state = context.watch<StateNotifier>();

    return Scaffold(
      appBar: AppBar(title: Text(widget.article.title)),
      floatingActionButton: FutureBuilder<bool>(
      future: isCart,
      builder: (context, result) {
        if (result.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Afficher un indicateur de chargement pendant l'attente
        } else if (result.hasError) {
          return Text('Error: ${result.error}'); // Afficher un message d'erreur s'il y a une erreur lors de la récupération de la valeur
        } else {
          final bool cartInProduct = result.data ?? false;
          return FloatingActionButton(
            onPressed: () {
              addButton();
            },
            backgroundColor: Colors.orangeAccent,
            child: cartInProduct
                ? const Icon(Icons.shopping_cart, size: 22)
                : const Icon(Icons.shopping_cart_outlined, size: 22, ),
          );
        }
      },
    ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.article.image, fit: BoxFit.cover, width: double.infinity, height: 200,),
            Padding(padding: EdgeInsets.all(12), 
              child: Column(children: [
                const SizedBox(height: 16,),
                Text("Article ${widget.article.category}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                const SizedBox(height: 16,),
                Text(widget.article.description, style: const TextStyle(fontSize: 22, ),),    
                const SizedBox(height: 16,),
                Text('Price: ${widget.article.price}\$', style: const TextStyle(fontSize: 22, ),),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}