import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuka/layouts/app_view.dart';
import 'package:yuka/product/product.dart';

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

      //ici faire une requete avec le barcode et le retour de la requete ira en argument de yield ProductAvailableState ()

      // Requête
      yield ProductAvailableState(Product(
          barcode: barcode,
          name: 'Nouveau plat',
          brands: <String>['Cassegrain'],
          altName: 'Nouveau plat de petits pois'));
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
        return Scaffold(
            body: Center(
          child: AppView(
            barCode: this.barCode,
            scannedProduct: state.product,
          ),
        ));
      },
    );
  }
}
