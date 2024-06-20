import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
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

  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    error: true,
    compact: true,
    maxWidth: 90,
  ));

  getIt.registerSingleton<Dio>(dio);
  getIt.registerSingleton<TodoApiServices>(TodoApiServices(dio));
}
