import 'package:flutter/material.dart';
import 'package:yuka/repository/model/api_product.dart';
import 'package:yuka/theme/app_colors.dart';

import './card.dart';

class CharacteristicsView extends StatelessWidget {
  final APIProduct? scannedProduct;
  const CharacteristicsView({this.scannedProduct = null, Key? key})
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
                      child: ProductCharacteristics(),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(body: Center(child: Text('Pas de produits scannés')));
  }
}

class ProductCharacteristics extends StatelessWidget {
  const ProductCharacteristics({Key? key}) : super(key: key);

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
                    ? ProductCharacteristicsDetails(
                        label: 'Ingrédients',
                        characteristicsLabel: product.ingredients!.ingredients,
                        characteristicsDetails: null)
                    : Text('Pas de détails sur le produit'),
                product != null
                    ? ProductCharacteristicsDetails(
                        label: 'Substances allergènes',
                        characteristicsLabel: product.allergens!.list,
                        characteristicsDetails: null)
                    : Text('Pas de détails sur le produit'),
                product != null
                    ? ProductCharacteristicsDetails(
                        label: 'Additifs',
                        characteristicsLabel:
                            product.additives!.list.values.toList(),
                        characteristicsDetails: null)
                    : Text('Pas de détails sur le produit')
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
        this.characteristicsLabel != null
            ? Column(children: <Widget>[
                for (int i = 0; i < this.characteristicsLabel!.length; i++)
                  ProductField(
                      label: this.characteristicsLabel![i],
                      value: this.characteristicsDetails?[i] ?? '',
                      divider: true,
                      boldLabel: true)
              ])
            : ProductField(
                label: 'Aucun', value: '', divider: true, boldLabel: true)
      ],
    );
  }
}
