import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuka/layouts/app_view.dart';
import 'package:yuka/product/product.dart';
import 'package:yuka/repository/model/api_product.dart';
import 'package:yuka/repository/retrofit/api_yuka_product.dart';

// En entrée
abstract class ProductEvent {}

class FetchProductEvent extends ProductEvent {
  final String barcode;

  FetchProductEvent(this.barcode);
}

// En sortie
abstract class ProductState {
  final Product? product;

  ProductState(this.product);
}

//Initial product
class InitialState extends ProductState {
  InitialState() : super(null);
}

//new Event
class ProductAvailableState extends ProductState {
  ProductAvailableState(Product product) : super(product);
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  // Donner la valeur initiale
  ProductBloc() : super(InitialState());

  void fetchProduct(String barcode) {
    add(FetchProductEvent(barcode));
  }

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is FetchProductEvent) {
      String barcode = event.barcode;
      final ApiYukaProduct client =
          ApiYukaProduct(Dio(BaseOptions(contentType: 'application/json')));

      //ici faire une requete avec le barcode et le retour de la requete ira en argument de yield ProductAvailableState ()
      final APIGetProductResponse data =
          await client.getProduct(barCodeParam: barcode);

      // Requête
      yield ProductAvailableState(Product(
          barcode: barcode,
          name: data.response!.name,
          altName: data.response!.altName,
          picture: data.response!.picture,
          brands: data.response!.brands,
          quantity: data.response!.quantity,
          manufacturingCountries: data.response!.manufacturingCountries));
    }
  }
}

class MyTest extends StatelessWidget {
  final String? barCode;

  const MyTest({this.barCode = null, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductBloc _productBloc = BlocProvider.of<ProductBloc>(context);
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: _productBloc,
      builder: (BuildContext context, ProductState state) {
        return state.product is Product
            ? Scaffold(
                body: Center(
                child: AppView(
                  barCode: this.barCode,
                  scannedProduct: state.product,
                ),
              ))
            : Scaffold(
                body: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Patientez quelques secondes...',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    CircularProgressIndicator()
                  ],
                )),
              );
      },
    );
  }
}
