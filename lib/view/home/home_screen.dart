import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/components/default_tab_bar_buttons.dart';
import 'package:la_vie_app/core/components/default_text_form_field.dart';
import 'package:la_vie_app/core/enum/product_type.dart';
import 'package:la_vie_app/core/style/colors/app_colors.dart';
import 'package:la_vie_app/core/utils/navigation.dart';
import 'package:la_vie_app/cubit/product/product_cubit.dart';
import 'package:la_vie_app/cubit/quiz/quiz_cubit.dart';
import 'package:la_vie_app/view/cart/cart_screen.dart';
import 'package:la_vie_app/view/home/components/product_grid_view.dart';
import 'package:la_vie_app/view/quiz/quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> tabBarItems = ["All", "Plants", "Seeds", "Tools"];
  late List<Widget> gridViews;

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gridViews = [
      ProductGridView(
          products: ProductCubit.get(context).products,
          productsType: ProductType.All),
      ProductGridView(
          products: ProductCubit.get(context).plants,
          productsType: ProductType.Plant),
      ProductGridView(
          products: ProductCubit.get(context).seeds,
          productsType: ProductType.Seed),
      ProductGridView(
          products: ProductCubit.get(context).tools,
          productsType: ProductType.Tool),
    ];
  }

  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return Column(
          children: [
            BlocBuilder<QuizCubit, QuizState>(
              builder: (_, state) => AppBar(
                flexibleSpace: Center(
                  child: Image.asset(
                    "assets/logo/logo.png",
                    height: 100.h,
                    width: 100.w,
                  ),
                ),
                actions: [
                  if (QuizCubit.get(context).showQuiz())
                    IconButton(
                      onPressed: () {
                        NavigationUtils.navigateTo(
                            context: context,
                            destinationScreen: const QuizScreen());
                      },
                      icon: const Icon(
                        Icons.lightbulb_outline,
                        color: Colors.amber,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  if (isSearch) ...[
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isSearch = false;
                        });
                      },
                      icon: Icon(
                        Icons.arrow_back,
                      ),
                    ),
                  ],
                  Expanded(
                    child: DefaultTextFormField(
                      textInputType: TextInputType.text,
                      controller: searchController,
                      prefixIcon: Icons.search_rounded,
                      borderRadius: 10.r,
                      enabledBorderRadius: 10.r,
                      hasBorder: false,
                      isFilled: true,
                      fillColor: Colors.grey.shade100,
                      onChange: (String val) {
                        ProductCubit.get(context).searchProducts(val);
                      },
                      onTap: () {
                        setState(() {
                          isSearch = true;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      NavigationUtils.navigateTo(
                        context: context,
                        destinationScreen: CartScreen(),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: AppColors.primaryColor,
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isSearch) ...[
              Expanded(
                child: ProductGridView(
                  products: ProductCubit.get(context).searchedProducts,
                  productsType: ProductType.All,
                ),
              ),
            ],
            if (!isSearch) ...[
              SizedBox(
                height: 50.h,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => SizedBox(
                    width: 10.w,
                  ),
                  itemCount: tabBarItems.length,
                  itemBuilder: (context, index) => DefaultTabBarButtons(
                    title: tabBarItems[index],
                    isActive:
                        index == ProductCubit.get(context).currentTabBarItem,
                    onTap: () {
                      ProductCubit.get(context).changeCurrentTabBarItem(index);
                    },
                  ),
                ),
              ),
              Expanded(
                child: gridViews[ProductCubit.get(context).currentTabBarItem],
              ),
            ],
          ],
        );
      },
    );
  }
}
