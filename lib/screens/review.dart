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
  final TextEditingController _commentController = TextEditingController();
  final List<int> _stars = [1, 2, 3, 4, 5];
  int _selectedStar;
  @override
  void initState() {
    _selectedStar = null;
    _reviewsStore.initReviews();
    super.initState();
  }

  void _submitReview(String uniqueKey, ReviewModel review) {
    //_reviewsStore.updateReview(reviewModel)
    print("$uniqueKey $review.comment $review.rating");
    _reviewsStore.updateReview(review);
  }

  @override
  Widget build(BuildContext context) {
    bool isIos = Theme.of(context).platform == TargetPlatform.iOS;
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Review App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: screenWidth * 0.6,
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: "Write a review",
                      labelText: "Write a review",
                    ),
                  ),
                ),
                Container(
                  child: DropdownButton(
                    hint: Text("Stars"),
                    elevation: 0,
                    value: _selectedStar,
                    items: _stars.map((star) {
                      return DropdownMenuItem<int>(
                        child: Text(star.toString()),
                        value: star,
                      );
                    }).toList(),
                    onChanged: (item) {
                      setState(() {
                        _selectedStar = item;
                      });
                    },
                  ),
                ),
                Container(
                  child: Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: Icon(Icons.done),
                        onPressed: () {
                          if (_selectedStar == null) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("You can't add a review without star"),
                              duration: Duration(milliseconds: 500),
                            ));
                          } else if (_commentController.text.isEmpty) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Review comment cannot be empty"),
                              duration: Duration(milliseconds: 500),
                            ));
                          } else {
                            _reviewsStore.addReview(ReviewModel(
                                comment: _commentController.text,
                                stars: _selectedStar));
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
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
                            return WillPopScope( // TODO: not sure what the effect of this is at present
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
                                          isScrollControlled: true, // allow for keyboard
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
            )
          ],
        ),
      ),
    );
  }
}
