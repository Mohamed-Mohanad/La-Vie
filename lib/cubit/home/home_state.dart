part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class ChangeTabBarItem extends HomeState {}
class GetSeedsLoadingState extends HomeState {}
class GetSeedsSuccessfulState extends HomeState {}
class GetSeedsErrorState extends HomeState {}
class GetPlantsLoadingState extends HomeState {}
class GetPlantsSuccessfulState extends HomeState {}
class GetPlantsErrorState extends HomeState {}
class GetToolsLoadingState extends HomeState {}
class GetToolsSuccessfulState extends HomeState {}
class GetToolsErrorState extends HomeState {}
class GetAllProductsLoadingState extends HomeState {}
class GetAllProductsSuccessfulState extends HomeState {}
class GetAllProductsErrorState extends HomeState {}
class GetPlantDetailsLoadingState extends HomeState {}
class GetPlantDetailsSuccessfulState extends HomeState {}
class GetPlantDetailsErrorState extends HomeState {}
class ResetScanResultState extends HomeState {}