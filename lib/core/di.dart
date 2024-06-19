import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_todo/data/api_services.dart';

final getIt = GetIt.instance;

void setup() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
    ),
  );


  getIt.registerSingleton<Dio>(dio);
  getIt.registerSingleton<TodoApiServices>(TodoApiServices(dio));
}
