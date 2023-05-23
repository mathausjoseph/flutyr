import 'package:flutter/material.dart';
import '/pages/category_detail.dart';

class CategoryWidgetSingle extends StatelessWidget {
  final String category;
  final VoidCallback onTapDetail;
  const CategoryWidgetSingle({Key? key, required this.category, required this.onTapDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 38, width: 19, child: Icon(Icons.pages, size: 12,)),
            InkWell(
              onTap: (() => {Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryDetail(category: category)))}),
              child: Text(category, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.deepPurple, ),),
            ),
          ],
      ),
    );
  }
}

class CategoryListWidget extends StatefulWidget {
  final Future<List> Function() getCategories;
  const CategoryListWidget({Key? key, required this.getCategories}) : super(key: key);

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  late Future<List> _categories;
  late Key _key;
  
  @override
  void initState() {
    super.initState();
    _categories = widget.getCategories();
    _key = UniqueKey();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      key: _key,
      future: _categories,
      builder: (context, categoryList) {
        if (categoryList.hasData) {
          
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
            children: categoryList.data!.map((item) => CategoryWidgetSingle(category: item, onTapDetail: () {
              })).toList(),
            ),  
          );
        } else if(categoryList.hasError) {
          return Center(
            child: Column(
              children: [
                Text("${categoryList.error}", style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),),
                const SizedBox(height: 10,),
                ElevatedButton(onPressed: () {
                  setState(() {
                    _categories = widget.getCategories();
                    _key = UniqueKey();
                  });
                }, child: const Text("Retry"))
              ],
            ),
          );
        }else {
          return const CircularProgressIndicator();
        }
      } 
    );
  }
}