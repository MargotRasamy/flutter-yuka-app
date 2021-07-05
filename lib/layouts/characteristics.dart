import 'package:flutter/material.dart';
import 'package:yuka/theme/app_colors.dart';

import './card.dart';
import '../product/product.dart';

class CharacteristicsView extends StatelessWidget {
  const CharacteristicsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product product = Product(
        barcode: '12345678',
        name: 'Petits pois et carotes',
        brands: <String>['Cassegrain'],
        altName: "Petits pois et carottes à l'étuvée avec garniture");

    return Scaffold(
      body: SizedBox.expand(
        child: ProductHolder(
          product: product,
          child: Stack(
            children: <Widget>[
              ProductImage(),
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 250.0,
                bottom: 0.0,
                child: ProductCharacteristics(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCharacteristics extends StatelessWidget {
  const ProductCharacteristics({Key? key}) : super(key: key);

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
                ProductCharacteristicsDetails(
                    label: 'Ingrédients',
                    characteristicsLabel: <String>[
                      'Sucre',
                      'Cholesterol',
                      'Sucre',
                      'Cholesterol'
                    ],
                    characteristicsDetails: <String>[
                      '2 grammes',
                      '3%',
                      '2 grammes',
                      '3%'
                    ]),
                ProductCharacteristicsDetails(
                    label: 'Substances allergènes',
                    characteristicsLabel: null,
                    characteristicsDetails: null)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductCharacteristicsDetails extends StatelessWidget {
  final String label;
  final List<String>? characteristicsLabel;
  final List<String>? characteristicsDetails;

  ProductCharacteristicsDetails({
    required this.label,
    required this.characteristicsLabel,
    required this.characteristicsDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: double.infinity,
            height: 40,
            color: AppColors.gray1,
            child: Center(
              child: Text(
                this.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.blue,
                ),
              ),
            )),
        this.characteristicsDetails is List<String>
            ? Column(children: <Widget>[
                for (int i = 0; i < this.characteristicsDetails!.length; i++)
                  ProductField(
                    label: this.characteristicsLabel![i],
                    value: this.characteristicsDetails![i],
                    divider: true,
                  )
              ])
            : ProductField(
                label: 'Aucun',
                value: '',
                divider: true,
              )
      ],
    );
  }
}
