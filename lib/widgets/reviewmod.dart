import 'package:flutter/material.dart';

class ReviewMod extends StatefulWidget {
  ReviewMod({Key key}) : super(key: key);

  @override
  ReviewModState createState() => ReviewModState();
}

class ReviewModState extends State<ReviewMod> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
      height: 160,
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
      )
    );
  }
}

