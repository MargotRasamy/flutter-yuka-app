// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_yuka_product.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiYukaProduct implements ApiYukaProduct {
  _ApiYukaProduct(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.formation-android.fr/v2';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<APIGetProductResponse> getProduct(
      {barCodeParam = '5000159484695'}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'barcode': barCodeParam};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<APIGetProductResponse>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/getProduct',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = APIGetProductResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
