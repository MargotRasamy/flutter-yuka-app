import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yuka/res/app_icons.dart';
import 'package:yuka/theme/app_colors.dart';

import 'layouts/app_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenFoodFacts - Margot Rasamy',
      theme: ThemeData(fontFamily: 'Avenir', primaryColor: AppColors.white),
      home: MyHomePage(title: 'OpenFoodFacts'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return Theme(
      data: Theme.of(context).copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.white,
          elevation: 0.0,
          centerTitle: false,
          iconTheme: IconTheme.of(context).copyWith(
            color: primaryColor,
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Mes scans',
            style:
                TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () async {
                    // await FlutterBarcodeScanner.scanBarcode(
                    //     '#ff6666', 'Retour', true, ScanMode.DEFAULT);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AppView(barCode: '5000159484695')),
                    );
                  },
                  icon: const Icon(AppIcons.barcode),
                  color: AppColors.black),
            )
          ],
        ),
        body: Center(
            child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SvgPicture.asset('res/svg/ill_empty.svg'),
                    const SizedBox(
                      height: 27.0,
                    ),
                    Text(
                      "Vous n'avez pas encore scanné de produit",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Avenir',
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                    const SizedBox(
                      height: 27.0,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => AppView()),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'COMMENCER',
                              style: TextStyle(
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.w800),
                            ),
                            Icon(Icons.arrow_right_alt),
                          ],
                        ),
                        style: OutlinedButton.styleFrom(
                          primary: AppColors.blue,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22.0))),
                          backgroundColor: AppColors.yellow,
                          padding: EdgeInsets.symmetric(
                              horizontal: 28, vertical: 14),
                        ))
                  ],
                ))),
      ),
    );
  }
}
