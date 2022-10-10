import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_rest/screens/users_screen.dart';
import 'package:flutter_shop_rest/services/api_handler.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';

import '../consts/global_colors.dart';
import '../models/product_model.dart';
import '../widgets/appbar_icons.dart';
import '../widgets/feeds_grid.dart';
import '../widgets/feeds_widget.dart';
import '../widgets/sale_widget.dart';
import 'categories_screen.dart';
import 'feeds_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _textEditingController;
  // List<ProductsModel> productsList = [];
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

/*  @override
  void didChangeDependencies() async {
    productsList = await APIHandler.getAllProducts();
    super.didChangeDependencies();
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 4,
          title: const Text('Home'),
          leading: AppBarIcons(
            function: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const CategoriesScreen(),
                ),
              );
            },
            icon: IconlyBold.category,
          ),
          actions: [
            AppBarIcons(
              function: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const UsersScreen(),
                  ),
                );
              },
              icon: IconlyBold.user_3,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(
                height: 18,
              ),
              TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "Search",
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 1,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    suffixIcon: Icon(
                      IconlyBold.search,
                      color: lightIconsColor,
                    )),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 18,
                      ),
                      SizedBox(
                        height: size.height * 0.20,
                        child: Swiper(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return SaleWidget();
                          },
                          pagination: const SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                color: Colors.white,
                                activeColor: Colors.red,
                              )),
                          control: const SwiperControl(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Latest Products",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          AppBarIcons(
                            function: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const FeedsScreen()));
                            },
                            icon: IconlyBold.arrow_right_2,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder<List<ProductsModel>>(
                        future: APIHandler.getAllProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                          return FeedsGridWidget(productsList: snapshot.data!);
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
