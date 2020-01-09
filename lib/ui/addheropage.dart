import 'package:flutter/material.dart';

class AddHeroPage extends StatefulWidget {
  @override
  _AddHeroPageState createState() => _AddHeroPageState();
}

class _AddHeroPageState extends State<AddHeroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterBloc Hero List'),
      ),
      body: Center(
        child: Text('Add Hero Page'),
      ),
    );
  }
}
