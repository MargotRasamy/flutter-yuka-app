import 'package:flutter/material.dart';
import 'package:yuka/theme/app_colors.dart';

class CardView extends StatefulWidget {
  CardView({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
            fit: StackFit.expand,
            alignment: AlignmentDirectional.topStart,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                    width: 300,
                    height: 350,
                    child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://www.tounsia.net/media/cache/singlepost/uploads/2016/10/xpancake.jpeg.pagespeed.ic.UD3vuMsHzl.webp'))),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.0),
                          bottom: Radius.circular(0.0)),
                      color: AppColors.white,
                    ),
                    height: 450,
                    child: Text(
                      'Petits pois et carottes',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                    )),
              )
            ]),
      ),
    );
  }
}
