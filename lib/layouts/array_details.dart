import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuka/theme/app_colors.dart';

import './card.dart';
import '../product/product.dart';

class ArrayDetailsView extends StatelessWidget {
  final Product? scannedProduct;
  const ArrayDetailsView({this.scannedProduct = null, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return this.scannedProduct != null
        ? Scaffold(
            body: SizedBox.expand(
              child: ProductHolder(
                product: this.scannedProduct!,
                child: Stack(
                  children: <Widget>[
                    ProductImage(),
                    Positioned(
                      left: 0.0,
                      right: 0.0,
                      top: 250.0,
                      bottom: 0.0,
                      child: ProductArrayDetails(),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Text('Pas de produits scannés');
  }
}

class ProductArrayDetails extends StatelessWidget {
  const ProductArrayDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(16.0),
      topRight: Radius.circular(16.0),
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: borderRadius,
      ),
      child: SingleChildScrollView(
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductTitle(),
                const SizedBox(
                  height: 10.0,
                ),
                TableNutritionDetails(
                  foodNutritionDetails: {
                    'carbohydrate': {
                      'unit': 'g',
                      'perServing': '15.7',
                      'per100g': '36.4'
                    },
                    'sugar': {
                      'unit': 'g',
                      'perServing': '12.6',
                      'per100g': '29.2'
                    },
                    'fiber': null,
                    'proteins': {
                      'unit': 'g',
                      'perServing': '1.21',
                      'per100g': '2.8'
                    },
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TableCellElement extends StatelessWidget {
  final String text;
  final bool bold;
  final bool justifiedLeft;

  TableCellElement(
      {this.text = '', this.bold = false, this.justifiedLeft = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: this.justifiedLeft
            ? EdgeInsets.symmetric(horizontal: 6, vertical: 0)
            : null,
        alignment: Alignment.center,
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: this.justifiedLeft
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            Text(this.text,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: AppColors.blue,
                    fontWeight:
                        this.bold ? FontWeight.bold : FontWeight.normal)),
          ],
        ));
  }
}

// calories;
// fat;
// saturatedFat;
// carbohydrate;
// sugar;
// fiber;
// proteins;
// sodium;
// salt;
// energy;

class TableNutritionDetails extends StatelessWidget {
  final Map<String, Map<String, String>?>?
      foodNutritionDetails; //TODO check type conformity

  static const List<Map<String, String>> nutritionTypeList =
      <Map<String, String>>[
    {'label': 'energy', 'name': 'Energie'},
    {'label': 'fat', 'name': 'Matières grasses'},
    {'label': 'saturatedFat', 'name': 'dont Acides gras saturés'},
    {'label': 'carbohydrate', 'name': 'Glucides'},
    {'label': 'sugar', 'name': 'dont Sucres'},
    {'label': 'fiber', 'name': 'Fibres alimentaires'},
    {'label': 'proteins', 'name': 'Protéines'},
    {'label': 'salt', 'name': 'Sel'},
    {'label': 'sodium', 'name': 'Sodium'}
  ];

  TableNutritionDetails({required this.foodNutritionDetails});

  @override
  Widget build(BuildContext context) {
    return this.foodNutritionDetails != null // TODO change is NutritionFacts
        ? Column(children: [
            Table(
                border: TableBorder.all(color: AppColors.gray2),
                columnWidths: {
                  0: FlexColumnWidth(2.2)
                },
                children: [
                  TableRow(children: [
                    TableCellElement(),
                    TableCellElement(text: 'Pour 100g', bold: true),
                    TableCellElement(text: 'Par part', bold: true),
                  ]),
                  for (int i = 0; i < nutritionTypeList.length; i++)
                    this.foodNutritionDetails!.containsKey(
                            nutritionTypeList[i] //TODO check if working well
                                ['label']) //TODO check if working
                        ? TableRow(children: <TableCellElement>[
                            TableCellElement(
                                text: nutritionTypeList[i]['name']!,
                                bold: true,
                                justifiedLeft: true),
                            TableCellElement(
                                text: this.foodNutritionDetails?[
                                                nutritionTypeList[i]['label']]
                                            ?['per100g'] !=
                                        null
                                    ? "${this.foodNutritionDetails![nutritionTypeList[i]['label']]!['per100g']} ${this.foodNutritionDetails?[nutritionTypeList[i]['label']]?['unit'] ?? 'g'}"
                                    : 'N.C'),
                            TableCellElement(
                                text: this.foodNutritionDetails?[
                                                nutritionTypeList[i]['label']]
                                            ?['perServing'] !=
                                        null
                                    ? "${this.foodNutritionDetails![nutritionTypeList[i]['label']]!['per100g']} ${this.foodNutritionDetails?[nutritionTypeList[i]['label']]?['unit'] ?? 'g'}"
                                    : 'N.C'),
                          ])
                        : TableRow(children: <TableCellElement>[
                            TableCellElement(
                                text: nutritionTypeList[i]['name']!,
                                bold: true,
                                justifiedLeft: true),
                            TableCellElement(text: 'N.C'),
                            TableCellElement(text: 'N.C'),
                          ])
                ]),
          ])
        : Text('Aucun détails');
  }
}

// "nutritionFacts":{
// "servingSize":"43.1ml",
// "calories":null,
// "fat":{
// "unit":"g",
// "perServing":"6.12",
// "per100g":"14.2"
// },
// "saturatedFat":{ gras saturés
// "unit":"g",
// "perServing":"4.14",
// "per100g":"9.6"
// },
// "carbohydrate":{ glucide
// "unit":"g",
// "perServing":"15.7",
// "per100g":"36.4"
// },
// "sugar":{ sucre
// "unit":"g",
// "perServing":"12.6",
// "per100g":"29.2"
// },
// "fiber":null,
// "proteins":{
// "unit":"g",
// "perServing":"1.21",
// "per100g":"2.8"
// },
// "sodium":{
// "unit":"g",
// "perServing":"0.0465",
// "per100g":"0.108"
// },
// "salt":{
// "unit":"g",
// "perServing":"0.116",
// "per100g":"0.27"
// },
// "energy":{
// "unit":"kJ",
// "perServing":"517",
// "per100g":"1199"
// }
