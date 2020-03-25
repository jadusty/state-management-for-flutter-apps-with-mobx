import 'package:flutter/material.dart';
import 'package:reviewapp/models/reviewmodel.dart';
import 'package:reviewapp/widgets/starrating.dart';

class ReviewMod extends StatefulWidget {
  final Function submitRating;
  final ReviewModel review;

  ReviewMod(this.submitRating, this.review, {Key key}) : super(key: key);

  @override
  ReviewModState createState() => ReviewModState(
      this.review.uniqueKey, this.review.comment, this.review.stars);
}

class ReviewModState extends State<ReviewMod> {
  final _commentController = TextEditingController();
  String uniqueKey;
  String comment;
  int rating;

  ReviewModState(this.uniqueKey, this.comment, this.rating) {
    _commentController.text = comment;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _commentController.dispose();
    super.dispose();
  }

  void _submitRating() {
    if (_commentController.text.isEmpty) {
      return;
    }
    var thisReview = new ReviewModel.ofUnique(
        uniqueKey: uniqueKey, comment: comment, stars: rating);
    widget.submitRating(widget.review.uniqueKey, thisReview);
    Navigator.of(context).pop(rating);
  }

  void _changeComment() {
    comment = _commentController.text;
  }

  @override
  Widget build(BuildContext context) {
    _commentController.addListener(_changeComment);

    return Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(
                20.0, 20.0, 20.0, 0.0), // content padding
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StarRating(
                          onChanged: (index) {
                            setState(() {
                              rating = index;
                            });
                          },
                          value: rating,
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: 'Comment'),
                          controller: _commentController,
                          keyboardType: TextInputType.text,
                          onChanged: (comment) {
                            setState(() {
                              comment = comment;
                            });
                          },
                          //onSubmitted: (_) => _submitRating(),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              new FlatButton(
                                textColor: Colors.blue,
                                child: Text("CANCEL"),
                                onPressed: () {
                                  Navigator.of(context).pop(rating);
                                },
                              ),
                              new FlatButton(
                                textColor: Colors.blue,
                                child: Text("OK"),
                                onPressed: () {
                                  _submitRating();
                                },
                              )
                            ])
                      ])
                ])));
  }
}
