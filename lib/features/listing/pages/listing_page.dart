import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListingPage extends StatefulWidget{
  const ListingPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ListingPageState();
  }

}

class _ListingPageState extends State<ListingPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Text("listing"),
          )
      ),
    );
  }

}