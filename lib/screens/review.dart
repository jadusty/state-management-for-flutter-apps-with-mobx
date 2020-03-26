import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:reviewapp/widgets/reviewmod.dart';
import '../widgets/info_card.dart';
import '../models/reviews.dart';
import '../models/reviewmodel.dart';
import '../widgets/review.dart';

class Review extends StatefulWidget {
  @override
  ReviewState createState() {
    return new ReviewState();
  }
}

class ReviewState extends State<Review> {
  final Reviews _reviewsStore = Reviews();
  @override
  void initState() {
    _reviewsStore.initReviews();
    super.initState();
  }

  void _submitReview(String uniqueKey, ReviewModel review) {
    //_reviewsStore.updateReview(reviewModel)
    _reviewsStore.updateReview(review);
  }

  void _addReview(String uniqueKey, ReviewModel review) {
    //_reviewsStore.updateReview(reviewModel)
    _reviewsStore.addReview(review);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review App'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 12.0),
            //contains average stars and total reviews card
            Observer(
              builder: (_) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InfoCard(
                        infoValue: _reviewsStore.numberOfReviews.toString(),
                        infoLabel: "reviews",
                        cardColor: Colors.green,
                        iconData: Icons.comment),
                    InfoCard(
                      infoValue: _reviewsStore.averageStars.toStringAsFixed(2),
                      infoLabel: "average stars",
                      cardColor: Colors.lightBlue,
                      iconData: Icons.star,
                      key: Key('avgStar'),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 24.0),
            //the review menu label
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.comment),
                  SizedBox(width: 10.0),
                  Text(
                    "Reviews",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            //contains list of reviews
            Expanded(
              child: Container(
                child: Observer(
                  builder: (_) => _reviewsStore.reviews.isNotEmpty
                      ? new ListView.builder(
                          itemCount: _reviewsStore.reviews.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            final thisReview = _reviewsStore.reviews[index];
                            return WillPopScope(
                              // TODO: not sure what the effect of this is at present
                              onWillPop: () async =>
                                  false, //prevents Android back button and outside tap from popping it
                              child: GestureDetector(
                                child: Dismissible(
                                  key: Key(thisReview.uniqueKey),
                                  direction: DismissDirection.horizontal,
                                  child: ReviewWidget(
                                    reviewItem: thisReview,
                                  ),
                                  onDismissed: (direction) {
                                    if (direction ==
                                            DismissDirection.endToStart ||
                                        direction ==
                                            DismissDirection.startToEnd) {
                                      _reviewsStore
                                          .removeReview(thisReview.uniqueKey);
                                    }
                                  },
                                ),
                                onLongPress: () {
                                  // you can show an AlertDialog here with 3 options you need
                                  var bottomSheetController =
                                      showModalBottomSheet(
                                          // If your BottomSheetModel is Column make sure you add mainAxisSize: MainAxisSize.min, otherwise the sheet will cover the whole screen.
                                          isScrollControlled:
                                              true, // allow for keyboard
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ReviewMod(
                                                _submitReview, thisReview);
                                          });
                                  bottomSheetController
                                      .whenComplete(() => null)
                                      .then((value) {});
                                },
                              ),
                            );
                          })
                      : Text("No reviews yet"),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          var bottomSheetController = showModalBottomSheet(
              // If your BottomSheetModel is Column make sure you add mainAxisSize: MainAxisSize.min, otherwise the sheet will cover the whole screen.
              isScrollControlled: true, // allow for keyboard
              context: context,
              builder: (BuildContext context) {
                return ReviewMod(
                    _addReview, new ReviewModel(stars: 0, comment: ""));
              });
          bottomSheetController.whenComplete(() => null).then((value) {});
        },
      ),
    );
  }
}
