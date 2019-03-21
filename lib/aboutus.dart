import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
@override
_AboutPageState createState() => new _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
@override
Widget build(BuildContext context) {
return new Scaffold(
appBar: new AppBar(
title: new Text('About Page'),
),
  body: new Center(
    child: new Text('the first androis app demo by Maed technologies', style: new TextStyle(fontSize: 15)),
  )
);
}
}