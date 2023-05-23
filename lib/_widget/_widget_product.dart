import '/_models/article.dart';
import 'package:provider/provider.dart';
import '/_widget/_widget_btn.dart';
import 'package:flutter/material.dart';
import '/utils.dart';
import '/pages/product_detail.dart';

class ProductSingleWidget extends StatelessWidget {
  final Article article;
  final int userId;
  final VoidCallback onTapDetailsMeth;
  const ProductSingleWidget({Key? key, required this.article, required this.onTapDetailsMeth, required this.userId }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (() => onTapDetailsMeth()),
            child: Image.network(
              article.image,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(article.title, maxLines: 2,style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(article.description, maxLines: 2, style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 9),
                Text('Prix :${article.price}\$',style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                WidgetButton(userId: userId, productId: article.id),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductListWidget extends StatefulWidget {
  final Future<List<Article>> Function() getProducts;
  const ProductListWidget({Key? key, required this.getProducts}) : super(key: key);

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  late Future<List> _products;
  late Key _key;

  @override
  void initState() {
    super.initState();
    _products = widget.getProducts();
    _key = UniqueKey();
  }

  void navigateToArticleDetailPage(Article article, dynamic userId) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetail(article: article, userId: userId,)));
  }

  @override
  Widget build(BuildContext context) {
    StateNotifier appstate = context.watch<StateNotifier>();
    return FutureBuilder<List>(
      key: _key,
      future: _products,
      builder: (context,products) {
        if (products.hasData) {
          if (products.data!.isEmpty) {
            return const Center(
              child: Text("No products to display", style: TextStyle(
                fontSize: 20
              ),),
            );
          } else {
          return SingleChildScrollView(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                itemCount: products.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.45,
                  // childAspectRatio: 200/450,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                return ProductSingleWidget(
                  userId: appstate.isLogin() ? appstate.getUser()['id'] : -1,
                    article: products.data![index],
                      onTapDetailsMeth: () {
                        navigateToArticleDetailPage(products.data![index], appstate.isLogin() ? appstate.getUser()['id'] : -1);
                      },
                    );
                },
              ),
            );
          }
        } else if(products.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${products.error}"),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: () {
                  setState(() {
                    _products = widget.getProducts();
                    _key = UniqueKey();
                  });
                }, child: const Text("Retry"))
              ],
            ),
          );
        }else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}