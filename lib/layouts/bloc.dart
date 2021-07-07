import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuka/layouts/app_view.dart';
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
  final APIProduct? product;

  ProductState(this.product);
}

//Initial product
class InitialState extends ProductState {
  InitialState() : super(null);
}

//new Event
class ProductAvailableState extends ProductState {
  ProductAvailableState(APIProduct product) : super(product);
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

      final APIGetProductResponse data =
          await client.getProduct(barCodeParam: barcode);

      // PS: J'ai créé un objet Product et ai rempli chaque champ avec les champs de la réponse manuellement
      // car l'appel nous rend un APIProduct alors que le state attend un Product
      // Pas forcément optimal mais je n'ai pas trop compris pourquoi vous nous avez donné les classes dans api_product.dart et également
      // celles de product.dart. Il fallait n'en utiliser qu'un des 2 fichiers ? product.dart était censé être temporaire ?
      // Je n'ai pas réussi à vous contacter pour cette question.

      // Requête
      yield ProductAvailableState(data.response!);
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
        return state.product is APIProduct
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
