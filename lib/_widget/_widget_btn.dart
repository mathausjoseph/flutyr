import 'package:flutter/material.dart';
import '/utils.dart';
import '/storage/storage.dart';
//johnd0
// m38rmF$
class WidgetButton extends StatefulWidget {
  final int userId; 
  final int productId; 
  const WidgetButton({Key? key, required this.userId, required this.productId}) : super(key: key);

  @override
  State<WidgetButton> createState() => _WidgetButtonState();
}

class _WidgetButtonState extends State<WidgetButton> {
  late Future<bool> isFavorite;
  late Future<bool> isCart;

  @override
  void initState() {
    super.initState();
    isFavorite = Storage.isProductFavorite(widget.userId, widget.productId);
    isCart = Storage.isCartInProduct(widget.userId, widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    const double iconSize = 30;
    return Row(children: [
      FutureBuilder(future:  isCart, builder: (context, result) {
        if (result.hasData) {
          return IconButton(onPressed: () async {
            if (widget.userId!=-1) {
              await Storage.toggleCartsProduct(widget.userId, widget.productId);
              setState(() {
                isCart = Storage.isCartInProduct(widget.userId, widget.productId);
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("You must connected to add to shop")));
            }          
          }, 
          icon: result.data! ?  const Icon(Icons.shopping_cart, size: iconSize,) : const Icon(Icons.shopping_cart_outlined, size: iconSize,),
          color: Colors.amber);
        } else if(result.hasError) {
          return Text("${result.error}");
        } else {
          return const CircularProgressIndicator();
        }
      }) ,

      const SizedBox(width: 15,),

      FutureBuilder(future:  isFavorite, builder: (context, result) {
        if (result.hasData) {
          return IconButton(onPressed: () async {
            if (widget.userId!=-1) {
              await Storage.toggleFavoriteProduct(widget.userId, widget.productId);
              setState(() {
                isFavorite = Storage.isProductFavorite(widget.userId, widget.productId);
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("You must connected to add to favorite")));
            }          
          }, 
          icon: result.data! ?  const Icon(Icons.favorite, size: iconSize,) : const Icon(Icons.favorite_outline, size: iconSize,),
          color: Colors.amber,);
        } else if(result.hasError) {
          return Text("${result.error}");
        } else {
          return const CircularProgressIndicator();
        }
      }),
    ],
    );
  }
  
}


class WidgetSingleButton extends StatefulWidget {
  final int userId; 
  final int productId; 
  const WidgetSingleButton({Key? key, required this.userId, required this.productId}) : super(key: key);

  @override
  State<WidgetButton> createState() => _WidgetButtonState();
}


class _WidgetSingleButtonState extends State<WidgetButton> {
  late Future<bool> isFavorite;
  late Future<bool> isCart;

  @override
  void initState() {
    super.initState();
    isFavorite = Storage.isProductFavorite(widget.userId, widget.productId);
    isCart = Storage.isCartInProduct(widget.userId, widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    const double iconSize = 30;
    return Row(children: [
      FutureBuilder(future:  isCart, builder: (context, result) {
        if (result.hasData) {
          return IconButton(onPressed: () async {
            if (widget.userId!=-1) {
              await Storage.toggleCartsProduct(widget.userId, widget.productId);
              setState(() {
                isCart = Storage.isCartInProduct(widget.userId, widget.productId);
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("You must connected to add to shop")));
            }          
          }, 
          icon: result.data! ?  const Icon(Icons.shopping_cart, size: iconSize,) : const Icon(Icons.shopping_cart_outlined, size: iconSize,),
          color: Colors.blue,);
        } else if(result.hasError) {
          return Text("${result.error}");
        } else {
          return const CircularProgressIndicator();
        }
      }) ,

      const SizedBox(width: 15,),

      FutureBuilder(future:  isFavorite, builder: (context, result) {
        if (result.hasData) {
          return IconButton(onPressed: () async {
            if (widget.userId!=-1) {
              await Storage.toggleFavoriteProduct(widget.userId, widget.productId);
              setState(() {
                isFavorite = Storage.isProductFavorite(widget.userId, widget.productId);
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("You must connected to add to favorite")));
            }          
          }, 
          icon: result.data! ?  const Icon(Icons.favorite, size: iconSize,) : const Icon(Icons.favorite_outline, size: iconSize,),
          color: Colors.blue,);
        } else if(result.hasError) {
          return Text("${result.error}");
        } else {
          return const CircularProgressIndicator();
        }
      }),
    ],
    );
  }
  
}


