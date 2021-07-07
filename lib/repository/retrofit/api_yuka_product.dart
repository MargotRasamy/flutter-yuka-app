import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:yuka/repository/model/api_product.dart';

part 'api_yuka_product.g.dart';

@RestApi(baseUrl: 'https://api.formation-android.fr/v2')
abstract class ApiYukaProduct {
  factory ApiYukaProduct(Dio dio, {String baseUrl}) = _ApiYukaProduct;

  @GET('/getProduct')
  Future<APIGetProductResponse> getProduct(
      {@Query('barcode') String barCodeParam});
}
