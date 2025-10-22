import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MePage extends StatefulWidget{
  const MePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MePageState();
  }

}

class _MePageState extends State<MePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Text("me"),
          )
      ),
    );
  }

}