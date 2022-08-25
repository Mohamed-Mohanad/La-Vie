import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie_app/models/products/plant.dart';
import 'package:la_vie_app/models/products/product.dart';
import 'package:la_vie_app/models/products/seed.dart';
import 'package:la_vie_app/models/products/tool.dart';
import 'package:la_vie_app/repositories/src/local/shared_preference/cache_keys.dart';
import 'package:la_vie_app/repositories/src/remote/dio/dio_helper.dart';
import 'package:la_vie_app/repositories/src/remote/dio/end_points.dart';

import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(HomeInitial());
  static ProductCubit get(context) => BlocProvider.of(context);

  int currentTabBarItem = 0;

  void changeCurrentTabBarItem(int index) {
    currentTabBarItem = index;
    emit(ChangeTabBarItem());
  }

  List<Product> products = [];
  List<Seed> seeds = [];
  List<Plant> plants = [];
  List<Tool> tools = [];
  void getAllProducts() {
    products.clear();
    seeds.clear();

    tools.clear();
    emit(GetAllProductsLoadingState());
    DioHelper.getData(
      url: EndPoints.ALL_PRODUCTS,
      token: CacheKeysManger.getUserTokenFromCache(),
    ).then((value) {
      _getPlants(value);
      _getSeeds(value);
      _getTools(value);
      emit(GetAllProductsSuccessfulState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetAllProductsErrorState());
    });
  }

  void _getPlants(Response<dynamic> response) {
    plants.clear();
    for (var element in response.data['data']['plants']) {
      products.add(Plant.fromJson(element));
      plants.add(Plant.fromJson(element));
    }
  }

  void _getSeeds(Response<dynamic> response) {
    seeds.clear();
    for (var element in response.data['data']['seeds']) {
      products.add(Plant.fromJson(element));
      seeds.add(Seed.fromJson(element));
    }
  }

  void _getTools(Response<dynamic> response) {
    tools.clear();
    for (var element in response.data['data']['tools']) {
      products.add(Plant.fromJson(element));
      tools.add(Tool.fromJson(element));
    }
  }

  Plant? scannedPlant;
  void getPlantDetails(
    String plantId,
  ) {
    emit(GetPlantDetailsLoadingState());
    DioHelper.getData(
      url: EndPoints.PLANT,
      query: {
        "plantId": plantId,
      },
      token: CacheKeysManger.getUserTokenFromCache(),
    ).then((value) {
      scannedPlant = Plant.fromJson(value.data["data"][0]);
      emit(GetPlantDetailsSuccessfulState());
    }).catchError((error) {
      emit(GetPlantDetailsErrorState());
    });
  }

  List<Product> searchedProducts = [];
  void searchProducts(String word) {
    searchedProducts.clear();
    emit(SearchLoadingState());
    for (var element in products) {
      if (element.name!.contains(word)) {
        searchedProducts.add(element);
      }
    }
    emit(SearchSuccessState());
  }
}
