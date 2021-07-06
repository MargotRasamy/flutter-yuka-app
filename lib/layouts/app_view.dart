import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuka/layouts/array_details.dart';
import 'package:yuka/layouts/card.dart';
import 'package:yuka/layouts/characteristics.dart';
import 'package:yuka/layouts/nutrition.dart';
import 'package:yuka/product/product.dart';
import 'package:yuka/res/app_icons.dart';

enum ProductDetailsCurrentTab { summary, info, nutrition, nutrionalValues }

class AppView extends StatefulWidget {
  final String? barCode;
  final Product? scannedProduct;

  AppView({this.barCode = null, this.scannedProduct = null, Key? key})
      : super(key: key); //TODO to use it widget.barCode

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  // Product? myProduct;
  int _counter = 0;

  // @override
  // void initState() {
  //   myProduct = widget.scannedProduct;
  // }

  final List<StatelessWidget> tabs = [
    CardView(),
    CharacteristicsView(),
    NutritionView(),
    ArrayDetailsView()
  ];

  List<StatelessWidget> returnView(Product? product) {
    return [
      CardView(scannedProduct: product),
      CharacteristicsView(scannedProduct: product),
      NutritionView(scannedProduct: product),
      ArrayDetailsView(scannedProduct: product)
    ];
  }

  void _incrementCounter(int index) {
    setState(() {
      this._counter = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: returnView(widget.scannedProduct)[this._counter],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: this._counter,
          iconSize: 24,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: (int index) => this._incrementCounter(index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(AppIcons.tabBarcode),
              label: 'Fiche',
            ),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.tabFridge),
              label: 'Caractéristiques',
            ),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.tabNutrition),
              label: 'Nutrition',
            ),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.tabArray),
              label: 'Tableau',
            )
          ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
