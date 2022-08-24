import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie_app/models/products/all_products.dart';
import 'package:la_vie_app/models/products/plants.dart';
import 'package:la_vie_app/models/products/seeds.dart';
import 'package:la_vie_app/models/products/tools.dart';
import 'package:la_vie_app/repositories/src/local/shared_preference/cache_keys.dart';
import 'package:la_vie_app/repositories/src/remote/dio/dio_helper.dart';
import 'package:la_vie_app/repositories/src/remote/dio/end_points.dart';

import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  int currentTabBarItem = 0;
  void changeCurrentTabBarItem(int index) {
    currentTabBarItem = index;
    emit(ChangeTabBarItem());
  }

  AllProductsResponse? allProductsResponse;
  List<dynamic> products = [];
  void getAllProducts() {
    emit(GetAllProductsLoadingState());
    DioHelper.getData(
      url: EndPoints.ALL_PRODUCTS,
      token: CacheKeysManger.getUserTokenFromCache(),
    ).then((value) {
      allProductsResponse = AllProductsResponse.fromJson(value.data);
      fillProductsList();
      emit(GetAllProductsSuccessfulState());
    }).catchError((error) {
      emit(GetAllProductsErrorState());
    });
  }

  void fillProductsList() {
    for (dynamic item in allProductsResponse!.data.plants) {
      products.add(item);
    }
    for (dynamic item in allProductsResponse!.data.seeds) {
      products.add(item);
    }
    for (dynamic item in allProductsResponse!.data.tools) {
      products.add(item);
    }
    products.shuffle();
  }

  Seeds? seeds;
  void getSeeds() {
    emit(GetSeedsLoadingState());
    DioHelper.getData(
      url: EndPoints.SEEDS,
      token: CacheKeysManger.getUserTokenFromCache(),
    ).then((value) {
      seeds = Seeds.fromJson(value.data);
      emit(GetSeedsSuccessfulState());
    }).catchError((error) {
      emit(GetSeedsErrorState());
    });
  }

  Plants? plants;
  void getPlants() {
    emit(GetPlantsLoadingState());
    DioHelper.getData(
      url: EndPoints.PLANTS,
      token: CacheKeysManger.getUserTokenFromCache(),
    ).then((value) {
      plants = Plants.fromJson(value.data);
      emit(GetPlantsSuccessfulState());
    }).catchError((error) {
      emit(GetPlantsErrorState());
    });
  }

  Tools? tools;
  void getTools() {
    emit(GetToolsLoadingState());
    DioHelper.getData(
      url: EndPoints.TOOLS,
      token: CacheKeysManger.getUserTokenFromCache(),
    ).then((value) {
      tools = Tools.fromJson(value.data);
      emit(GetToolsSuccessfulState());
    }).catchError((error) {
      emit(GetToolsErrorState());
    });
  }

  Plant? scannedPlant;
  void getPlantDetails(String plantId) {
    emit(GetPlantDetailsLoadingState());
    DioHelper.getData(
      url: EndPoints.PLANT,
      query: {"plantId": plantId},
      token: CacheKeysManger.getUserTokenFromCache(),
    ).then((value) {
      scannedPlant = Plant.fromJson(value.data["data"][0]);
      emit(GetPlantDetailsSuccessfulState());
    }).catchError((error) {
      emit(GetPlantDetailsErrorState());
    });
  }

  void resetScannedResult() {
    scannedPlant = null;
    emit(state);
  }
}
