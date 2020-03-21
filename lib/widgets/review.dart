import 'package:flutter/material.dart';
import './starrating.dart';
import '../models/reviewmodel.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel reviewItem;

  const ReviewWidget({Key key, @required this.reviewItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  reviewItem.comment,
                ),
              ),
              StarRating(
                  value: reviewItem.stars,
                  size: 20.0,
                  iconsOnly: true,
                  onChanged: (index) {
                    return index;
                  })
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }
}
