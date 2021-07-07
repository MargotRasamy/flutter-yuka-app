import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuka/repository/model/api_product.dart';
import 'package:yuka/theme/app_colors.dart';

import './card.dart';

class NutritionView extends StatelessWidget {
  final APIProduct? scannedProduct;
  const NutritionView({this.scannedProduct = null, Key? key}) : super(key: key);

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
                      child: ProductNutrition(),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(body: Center(child: Text('Pas de produits scannés')));
  }
}

class ProductNutrition extends StatelessWidget {
  const ProductNutrition({Key? key}) : super(key: key);

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
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 35,
                  child: Text('Repères nutritionnels pour 100g',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.gray3)),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ProductNutritionField(
                    nutritionType: 'fat',
                    quantity: product?.nutrientLevels?.fat?.per100g ?? 0),
                ProductNutritionField(
                    nutritionType: 'sugar',
                    quantity: product?.nutrientLevels?.sugars?.per100g ?? 0),
                ProductNutritionField(
                    nutritionType: 'saturatedFat',
                    quantity:
                        product?.nutrientLevels?.saturatedFat?.per100g ?? 0),
                ProductNutritionField(
                    nutritionType: 'salt',
                    quantity: product?.nutrientLevels?.salt?.per100g ?? 0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum ProductQuantityLevel { low, moderate, high }

class ProductNutritionField extends StatelessWidget {
  final String nutritionType;
  final num quantity;
  final bool divider;

  ProductQuantityLevel checkIndicator(num quantityValue) {
    switch (this.nutritionType) {
      case 'fat':
        if (quantityValue <= 3) {
          return ProductQuantityLevel.low;
        } else if (quantityValue <= 20) {
          return ProductQuantityLevel.moderate;
        } else {
          return ProductQuantityLevel.high;
        }
      case 'saturatedFat':
        if (quantityValue <= 1.5) {
          return ProductQuantityLevel.low;
        } else if (quantityValue <= 5) {
          return ProductQuantityLevel.moderate;
        } else {
          return ProductQuantityLevel.high;
        }
      case 'sugar':
        if (quantityValue <= 5) {
          return ProductQuantityLevel.low;
        } else if (quantityValue <= 12.5) {
          return ProductQuantityLevel.moderate;
        } else {
          return ProductQuantityLevel.high;
        }
      case 'salt':
        if (quantityValue <= 0.3) {
          return ProductQuantityLevel.low;
        } else if (quantityValue <= 1.5) {
          return ProductQuantityLevel.moderate;
        } else {
          return ProductQuantityLevel.high;
        }
      default:
        return ProductQuantityLevel.low;
    }
  }

  String nutritionLabel(String nutritionType) {
    switch (nutritionType) {
      case 'fat':
        return 'Matières grasses / lipides';
      case 'saturatedFat':
        return 'Acides gras saturés';
      case 'sugar':
        return 'Sucres';
      case 'salt':
        return 'Sel';
      default:
        return '';
    }
  }

  String indicatorLabel(ProductQuantityLevel indicatorLevel) {
    switch (indicatorLevel) {
      case ProductQuantityLevel.low:
        return 'Faible quantité';
      case ProductQuantityLevel.moderate:
        return 'Quantité modérée';
      case ProductQuantityLevel.high:
        return 'Quantité élevée';
    }
  }

  Color indicatorColor(ProductQuantityLevel indicatorLevel) {
    switch (indicatorLevel) {
      case ProductQuantityLevel.low:
        return AppColors.nutrientLevelLow;
      case ProductQuantityLevel.moderate:
        return AppColors.nutrientKevelModerate;
      case ProductQuantityLevel.high:
        return AppColors.nutrientLevelHigh;
    }
  }

  ProductNutritionField(
      {required this.nutritionType,
      required this.quantity,
      this.divider = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                // flex: 1,
                child: Text(this.nutritionLabel(this.nutritionType),
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: AppColors.blue)),
              ),
              Expanded(
                  // flex: 1,
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(this.quantity.toString() + 'g',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: indicatorColor(
                              this.checkIndicator(this.quantity)))),
                  Text(indicatorLabel(this.checkIndicator(this.quantity)),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: indicatorColor(
                              this.checkIndicator(this.quantity)))),
                ],
              )),
            ],
          ),
        ),
        Divider(
          color: AppColors.gray2,
        ),
      ],
    );
  }
}
