import 'package:flutter/material.dart';
import 'package:yuka/repository/model/api_product.dart';
import 'package:yuka/res/resources.dart';
import 'package:yuka/theme/app_colors.dart';

import '../res/app_icons.dart';
import '../res/app_images.dart';

class CardView extends StatelessWidget {
  final APIProduct? scannedProduct;
  const CardView({this.scannedProduct = null, Key? key}) : super(key: key);

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
                      child: ProductDetails(),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(body: Center(child: Text('Pas de produits scannés')));
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    APIProduct? product = ProductHolder.of(context)?.product;

    return Container(
      width: double.infinity,
      height: 300.0,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(product!.picture ??
                  'https://user-images.githubusercontent.com/47315479/81145216-7fbd8700-8f7e-11ea-9d49-bd5fb4a888f1.png'))),
    );
  }
}

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

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
                ProductTitle(hasAltName: true),
                const SizedBox(
                  height: 10.0,
                ),
                ProductInfo(),
                const SizedBox(
                  height: 10.0,
                ),
                ProductFields(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductHolder extends InheritedWidget {
  final APIProduct product;

  const ProductHolder({
    required this.product,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  static ProductHolder? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProductHolder>();
  }

  @override
  bool updateShouldNotify(ProductHolder old) => product != old.product;
}

class ProductTitle extends StatelessWidget {
  final bool hasAltName;
  const ProductTitle({this.hasAltName = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    APIProduct? product = ProductHolder.of(context)?.product;

    if (product == null) {
      return SizedBox();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name ?? '',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(product.brands?.join(',') ?? '',
            style: TextStyle(fontSize: 19, color: AppColors.gray2)),
        const SizedBox(
          height: 8.0,
        ),
        Container(
          child: this.hasAltName
              ? Text(product.altName ?? '',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray3))
              : null,
        ),
        const SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}

class ProductInfo extends StatelessWidget {
  const ProductInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.gray1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ProductInfoLine1(),
          Divider(),
          ProductInfoLine2(),
        ],
      ),
    );
  }
}

class ProductInfoLine1 extends StatelessWidget {
  const ProductInfoLine1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 10.0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 45,
            child: ProductInfoNutriScore(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(),
          ),
          Expanded(
            flex: 55,
            child: ProductInfoNova(),
          ),
        ],
      ),
    );
  }
}

class ProductInfoNutriScore extends StatelessWidget {
  const ProductInfoNutriScore({Key? key}) : super(key: key);

  String returnNutriscoreImage(APIProductNutriscore? nutriscore) {
    switch (nutriscore) {
      case APIProductNutriscore.A:
        return AppImages.nutriscoreA;
      case APIProductNutriscore.B:
        return AppImages.nutriscoreB;
      case APIProductNutriscore.C:
        return AppImages.nutriscoreC;
      case APIProductNutriscore.D:
        return AppImages.nutriscoreD;
      case APIProductNutriscore.E:
        return AppImages.nutriscoreE;
      default:
        return AppImages.nutriscoreA;
    }
  }

  @override
  Widget build(BuildContext context) {
    APIProduct? product = ProductHolder.of(context)?.product;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nutri-Score',
            style:
                TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold)),
        Image.asset(returnNutriscoreImage(product?.nutriScore)),
      ],
    );
  }
}

class ProductInfoNova extends StatelessWidget {
  const ProductInfoNova({Key? key}) : super(key: key);

  String returnNovascoreLabel(APIProductNovaScore? novascore) {
    switch (novascore) {
      case APIProductNovaScore.Group1:
        return 'Aliments non transformés ou transformés minimalement';
      case APIProductNovaScore.Group2:
        return 'Ingrédients culinaires transformés';
      case APIProductNovaScore.Group3:
        return 'Aliments transformés';
      case APIProductNovaScore.Group4:
        return 'Produits alimentaires et boissons ultra-transformés';
      default:
        return 'Pas de score nova';
    }
  }

  @override
  Widget build(BuildContext context) {
    APIProduct? product = ProductHolder.of(context)?.product;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Groupe Nova',
            style:
                TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold)),
        Text(returnNovascoreLabel(product?.novaScore)),
      ],
    );
  }
}

class ProductInfoLine2 extends StatelessWidget {
  const ProductInfoLine2({Key? key}) : super(key: key);

  IconData returnEcoscoreImage(APIProductEcoScore? ecoscore) {
    switch (ecoscore) {
      case APIProductEcoScore.A:
        return AppIcons.ecoscoreA;
      case APIProductEcoScore.B:
        return AppIcons.ecoscoreB;
      case APIProductEcoScore.C:
        return AppIcons.ecoscoreC;
      case APIProductEcoScore.D:
        return AppIcons.ecoscoreD;
      case APIProductEcoScore.E:
        return AppIcons.ecoscoreE;
      default:
        return AppIcons.ecoscoreA;
    }
  }

  @override
  Widget build(BuildContext context) {
    APIProduct? product = ProductHolder.of(context)?.product;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('EcoScore',
              style: TextStyle(
                  color: AppColors.blue, fontWeight: FontWeight.bold)),
          Row(
            children: [
              Icon(returnEcoscoreImage(product?.ecoScore)),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Text('Impact environnemental'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ProductFields extends StatelessWidget {
  const ProductFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    APIProduct? product = ProductHolder.of(context)?.product;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ProductField(
          label: 'Quantité',
          value: product!.quantity ?? 'Non spécifié',
          divider: true,
          boldLabel: true,
        ),
        ProductField(
          label: 'Vendu',
          value: product.manufacturingCountries is List<String>
              ? product.manufacturingCountries![0]
              : 'Non spécifié',
          divider: false,
          boldLabel: true,
        ),
      ],
    );
  }
}

class ProductField extends StatelessWidget {
  final String label;
  final String value;
  final bool divider;
  final bool boldLabel;

  ProductField(
      {required this.label,
      required this.value,
      this.divider = true,
      this.boldLabel = false});

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
                child: Text(label,
                    style: this.boldLabel
                        ? TextStyle(
                            fontWeight: FontWeight.w700, color: AppColors.blue)
                        : null),
              ),
              Expanded(
                // flex: 1,
                child: Text(
                  value,
                  textAlign: TextAlign.end,
                ),
              ),
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
