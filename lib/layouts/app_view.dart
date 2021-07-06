import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuka/layouts/array_details.dart';
import 'package:yuka/layouts/card.dart';
import 'package:yuka/layouts/characteristics.dart';
import 'package:yuka/layouts/nutrition.dart';
import 'package:yuka/res/app_icons.dart';
import 'package:yuka/theme/app_colors.dart';

enum ProductDetailsCurrentTab { summary, info, nutrition, nutrionalValues }

class AppView extends StatefulWidget {
  AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  int _counter = 0;

  final List<StatelessWidget> tabs = [
    CardView(),
    CharacteristicsView(),
    NutritionView(),
    ArrayDetailsView()
  ];

  void _incrementCounter(int index) {
    setState(() {
      this._counter = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[this._counter],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: this._counter,
          type: BottomNavigationBarType.fixed,
          iconSize: 24,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: (int index) => this._incrementCounter(index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(AppIcons.tabBarcode),
              label: 'Fiche',
              backgroundColor: AppColors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.tabFridge),
              label: 'Caractéristiques',
              backgroundColor: AppColors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.tabNutrition),
              label: 'Nutrition',
              backgroundColor: AppColors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.tabArray),
              label: 'Tableau',
              backgroundColor: AppColors.blue,
            )
          ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
