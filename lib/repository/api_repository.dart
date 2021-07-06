import 'package:dio/dio.dart';
import 'package:yuka/repository/retrofit/api_yuka_product.dart';

class AppRepository {
  ApiYukaProduct _apiRequest;
  Dio dio;

  AppRepository() {
    dio = Dio();
    _apiRequest = ApiYukaProduct(dio);
  }
}
