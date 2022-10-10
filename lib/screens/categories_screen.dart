import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../services/api_handler.dart';
import '../widgets/category_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Categories")),
        body: FutureBuilder<List<Category>>(
          future: APIHandler.getAllCategory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              Center(
                child: Text('An error occured ${snapshot.error}'),
              );
            } else if (snapshot.data == null) {
              const Center(
                child: Text('No Products have been added yet'),
              );
            }
            return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (ctx, index) {
                  return ChangeNotifierProvider.value(
                      value: snapshot.data![index],
                      child: const CategoryWidget());
                });
          },
        ));
  }
}
