import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:simple_todo/model/get_todo.dart';
import 'package:simple_todo/model/new_todo.dart';
import 'package:simple_todo/model/update_todo.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: 'https://dummyjson.com')
abstract class TodoApiServices {
  factory TodoApiServices(Dio dio, {String baseUrl}) = _TodoApiServices;

  @GET("/todos")
  Future<GetTodos> getTodos(
    // @Query("limit") int limit, 
    // @Query("skip") int skip
    );

  @POST("/todos/add")
  Future<AddTodo> createCoupon(@Body() AddTodo body);

  @PUT("/todos/{id}")
  Future<UpdateTodo> updateTodo(@Path("id") int id, @Body() UpdateTodo updateTodo);

  @DELETE("/todos/{id}")
  Future<dynamic> deleteTodo(@Path("id") int id);
}
