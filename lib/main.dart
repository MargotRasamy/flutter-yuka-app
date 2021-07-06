import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yuka/repository/model/api_product.dart';
import 'package:yuka/repository/retrofit/api_yuka_product.dart';
import 'package:yuka/res/app_icons.dart';
import 'package:yuka/theme/app_colors.dart';

import 'layouts/bloc.dart';

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
        home: BlocProvider(
            create: (_) => ProductBloc(),
            child: MyHomePage(title: 'OpenFoodFacts')));
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
                      BlocProvider.of<ProductBloc>(context)
                          .fetchProduct('7949693950');
                      // await FlutterBarcodeScanner.scanBarcode(
                      //     '#ff6666', 'Retour', true, ScanMode.DEFAULT);
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
                                  builder: (BuildContext _) =>
                                      BlocProvider.value(
                                          value: BlocProvider.of<ProductBloc>(
                                              context),
                                          child:
                                              MyTest(barCode: '7949693950'))),
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
        ));
  }
}

class NewPage extends StatefulWidget {
  NewPage({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Flutter - Retrofit Implementation'),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Icon(Icons.cancel),
        backgroundColor: Colors.green,
      ),
    );
  }

  // build list view & manage states
  FutureBuilder<APIGetProductResponse> _buildBody(BuildContext context) {
    final ApiYukaProduct client =
        ApiYukaProduct(Dio(BaseOptions(contentType: 'application/json')));

    return FutureBuilder<APIGetProductResponse>(
      future: client.getProduct(),
      builder: (BuildContext context,
          AsyncSnapshot<APIGetProductResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildListView(context, snapshot.data!);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // build list view & its tile
  Widget _buildListView(
      BuildContext context, APIGetProductResponse productElement) {
    return Container(
      width: double.infinity,
      height: 500,
      child: Text(
        productElement.response?.altName ?? 'ge',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
