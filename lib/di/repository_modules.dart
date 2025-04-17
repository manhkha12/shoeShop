import 'package:shoe_store/data/repository/api_service.dart';
import 'package:shoe_store/data/repository/product_detail_repository.dart';
import 'package:shoe_store/data/repository/product_reponsitory.dart';
import 'package:shoe_store/data/repository/search_product_repository.dart';
import 'package:shoe_store/data/repository/user_repository.dart';
import 'package:get_it/get_it.dart';

Future<void> registerRepositoryModules(GetIt getIt) async {
  getIt
  ..registerLazySingleton(() => ApiService()) 
  ..registerLazySingleton(() => ProductRepository(apiService: getIt()))
  ..registerLazySingleton(() => ProductDetailRepository(apiService: getIt()))
  ..registerLazySingleton(() => SearchProductRepository(apiService: getIt()))
  ..registerLazySingleton<UserRepository>(() => UserRepository(getIt(), getIt()));
}
