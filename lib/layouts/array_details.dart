import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuka/repository/model/api_product.dart';
import 'package:yuka/theme/app_colors.dart';

import './card.dart';

class ArrayDetailsView extends StatelessWidget {
  final APIProduct? scannedProduct;
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
        : Scaffold(body: Center(child: Text('Pas de produits scannés')));
  }
}

class ProductArrayDetails extends StatelessWidget {
  const ProductArrayDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    APIProduct? product = ProductHolder.of(context)?.product;

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
                    product != null
                        ? TableNutritionDetails(
                            foodNutritionDetails: product.nutritionFacts,
                          )
                        : Text('Pas de détails sur ce produit')
                  ],
                ))),
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

enum NutritionTypes {
  energy,
  fat,
  saturatedFat,
  carbohydrate,
  sugar,
  fiber,
  proteins,
  salt,
  sodium
}

class TableNutritionDetails extends StatelessWidget {
  final APINutritionFacts? foodNutritionDetails; //TODO check type conformity

  String nutritionTypeLabel(NutritionTypes? nutritionType) {
    switch (nutritionType) {
      case NutritionTypes.energy:
        return 'Energie';
      case NutritionTypes.fat:
        return 'Matières grasses';
      case NutritionTypes.saturatedFat:
        return 'dont Acides gras saturés';
      case NutritionTypes.carbohydrate:
        return 'Glucides';
      case NutritionTypes.sugar:
        return 'dont Sucres';
      case NutritionTypes.fiber:
        return 'Fibres alimentaires';
      case NutritionTypes.proteins:
        return 'Protéines';
      case NutritionTypes.salt:
        return 'Sel';
      case NutritionTypes.sodium:
        return 'Sodium';
      default:
        return '';
    }
  }

  TableNutritionDetails({required this.foodNutritionDetails});

  @override
  Widget build(BuildContext context) {
    return this.foodNutritionDetails != null
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

                  // A partir de là
                  //J'ai tenté de faire une boucle mais le problème c'est que
                  //je ne peux itérer sur la classe

                  TableRow(children: <TableCellElement>[
                    TableCellElement(
                        text: nutritionTypeLabel(NutritionTypes.energy),
                        bold: true,
                        justifiedLeft: true),
                    TableCellElement(
                        text: this.foodNutritionDetails!.energy?.per100g != null
                            ? '${this.foodNutritionDetails!.energy?.per100g} ${this.foodNutritionDetails!.energy?.unit}'
                            : 'N.C'),
                    TableCellElement(
                        text: this.foodNutritionDetails!.energy?.perServing !=
                                null
                            ? '${this.foodNutritionDetails!.energy?.perServing} ${this.foodNutritionDetails!.energy?.unit}'
                            : 'N.C'),
                  ]),
                  TableRow(children: <TableCellElement>[
                    TableCellElement(
                        text: nutritionTypeLabel(NutritionTypes.fat),
                        bold: true,
                        justifiedLeft: true),
                    TableCellElement(
                        text: this.foodNutritionDetails!.fat?.per100g != null
                            ? '${this.foodNutritionDetails!.fat?.per100g} ${this.foodNutritionDetails!.fat?.unit}'
                            : 'N.C'),
                    TableCellElement(
                        text: this.foodNutritionDetails!.fat?.perServing != null
                            ? '${this.foodNutritionDetails!.fat?.perServing} ${this.foodNutritionDetails!.fat?.unit}'
                            : 'N.C'),
                  ]),
                  TableRow(children: <TableCellElement>[
                    TableCellElement(
                        text: nutritionTypeLabel(NutritionTypes.saturatedFat),
                        bold: true,
                        justifiedLeft: true),
                    TableCellElement(
                        text: this
                                    .foodNutritionDetails!
                                    .saturatedFat
                                    ?.per100g !=
                                null
                            ? '${this.foodNutritionDetails!.saturatedFat?.per100g} ${this.foodNutritionDetails!.saturatedFat?.unit}'
                            : 'N.C'),
                    TableCellElement(
                        text: this
                                    .foodNutritionDetails!
                                    .saturatedFat
                                    ?.perServing !=
                                null
                            ? '${this.foodNutritionDetails!.saturatedFat?.perServing} ${this.foodNutritionDetails!.saturatedFat?.unit}'
                            : 'N.C'),
                  ]),
                  TableRow(children: <TableCellElement>[
                    TableCellElement(
                        text: nutritionTypeLabel(NutritionTypes.carbohydrate),
                        bold: true,
                        justifiedLeft: true),
                    TableCellElement(
                        text: this
                                    .foodNutritionDetails!
                                    .carbohydrate
                                    ?.per100g !=
                                null
                            ? '${this.foodNutritionDetails!.carbohydrate?.per100g} ${this.foodNutritionDetails!.carbohydrate?.unit}'
                            : 'N.C'),
                    TableCellElement(
                        text: this
                                    .foodNutritionDetails!
                                    .carbohydrate
                                    ?.perServing !=
                                null
                            ? '${this.foodNutritionDetails!.carbohydrate?.perServing} ${this.foodNutritionDetails!.carbohydrate?.unit}'
                            : 'N.C'),
                  ]),
                  TableRow(children: <TableCellElement>[
                    TableCellElement(
                        text: nutritionTypeLabel(NutritionTypes.sugar),
                        bold: true,
                        justifiedLeft: true),
                    TableCellElement(
                        text: this.foodNutritionDetails!.sugar?.per100g != null
                            ? '${this.foodNutritionDetails!.sugar?.per100g} ${this.foodNutritionDetails!.sugar?.unit}'
                            : 'N.C'),
                    TableCellElement(
                        text: this.foodNutritionDetails!.sugar?.perServing !=
                                null
                            ? '${this.foodNutritionDetails!.sugar?.perServing} ${this.foodNutritionDetails!.sugar?.unit}'
                            : 'N.C'),
                  ]),
                  TableRow(children: <TableCellElement>[
                    TableCellElement(
                        text: nutritionTypeLabel(NutritionTypes.fiber),
                        bold: true,
                        justifiedLeft: true),
                    TableCellElement(
                        text: this.foodNutritionDetails!.fiber?.per100g != null
                            ? '${this.foodNutritionDetails!.fiber?.per100g} ${this.foodNutritionDetails!.fiber?.unit}'
                            : 'N.C'),
                    TableCellElement(
                        text: this.foodNutritionDetails!.fiber?.perServing !=
                                null
                            ? '${this.foodNutritionDetails!.fiber?.perServing} ${this.foodNutritionDetails!.fiber?.unit}'
                            : 'N.C'),
                  ]),
                  TableRow(children: <TableCellElement>[
                    TableCellElement(
                        text: nutritionTypeLabel(NutritionTypes.proteins),
                        bold: true,
                        justifiedLeft: true),
                    TableCellElement(
                        text: this.foodNutritionDetails!.proteins?.per100g !=
                                null
                            ? '${this.foodNutritionDetails!.proteins?.per100g} ${this.foodNutritionDetails!.proteins?.unit}'
                            : 'N.C'),
                    TableCellElement(
                        text: this.foodNutritionDetails!.proteins?.perServing !=
                                null
                            ? '${this.foodNutritionDetails!.proteins?.perServing} ${this.foodNutritionDetails!.proteins?.unit}'
                            : 'N.C'),
                  ]),
                  TableRow(children: <TableCellElement>[
                    TableCellElement(
                        text: nutritionTypeLabel(NutritionTypes.salt),
                        bold: true,
                        justifiedLeft: true),
                    TableCellElement(
                        text: this.foodNutritionDetails!.salt?.per100g != null
                            ? '${this.foodNutritionDetails!.salt?.per100g} ${this.foodNutritionDetails!.salt?.unit}'
                            : 'N.C'),
                    TableCellElement(
                        text: this.foodNutritionDetails!.salt?.perServing !=
                                null
                            ? '${this.foodNutritionDetails!.salt?.perServing} ${this.foodNutritionDetails!.salt?.unit}'
                            : 'N.C'),
                  ]),
                  TableRow(children: <TableCellElement>[
                    TableCellElement(
                        text: nutritionTypeLabel(NutritionTypes.sodium),
                        bold: true,
                        justifiedLeft: true),
                    TableCellElement(
                        text: this.foodNutritionDetails!.sodium?.per100g != null
                            ? '${this.foodNutritionDetails!.sodium?.per100g} ${this.foodNutritionDetails!.sodium?.unit}'
                            : 'N.C'),
                    TableCellElement(
                        text: this.foodNutritionDetails!.sodium?.perServing !=
                                null
                            ? '${this.foodNutritionDetails!.sodium?.perServing} ${this.foodNutritionDetails!.sodium?.unit}'
                            : 'N.C'),
                  ])

                  // for (NutritionTypes value in NutritionTypes.values)
                  //   TableRow(children: <TableCellElement>[
                  //     TableCellElement(
                  //         text: nutritionTypeLabel(value),
                  //         bold: true,
                  //         justifiedLeft: true),
                  //     TableCellElement(
                  //         text: this.foodNutritionDetails![nutritionTypeName(value)]?.per100g ?? ''),
                  //     TableCellElement(
                  //         text: this.foodNutritionDetails![nutritionTypeName(value)]?.perServing ?? ''),
                  //   ])
                ]),
          ])
        : Scaffold(body: Center(child: Text('Aucun détails')));
  }
}
