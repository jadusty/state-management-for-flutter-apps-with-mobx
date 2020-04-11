import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:reviewapp/widgets/reviewmod.dart';
import '../widgets/info_card.dart';
import '../models/reviews.dart';
import '../models/reviewmodel.dart';
import '../widgets/review.dart';
import '../widgets/fade_on_scroll.dart';

enum HeaderTypeEnum {
  HeaderTypeFull,
  HeaderTypeSimple,
}

class Review extends StatefulWidget {
  @override
  ReviewState createState() {
    return new ReviewState();
  }
}

class ReviewState extends State<Review> {
  final Reviews _reviewsStore = Reviews();
  @override
  initState() {
    _reviewsStore.initReviews();
    super.initState();
  }

  _submitReview(String uniqueKey, ReviewModel review) {
    //_reviewsStore.updateReview(reviewModel)
    _reviewsStore.updateReview(review);
  }

  _addReview(String uniqueKey, ReviewModel review) {
    //_reviewsStore.updateReview(reviewModel)
    _reviewsStore.addReview(review);
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = new ScrollController();
    return Scaffold(
        appBar: AppBar(
          title: Text('Review App'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Center(
            child: Observer(
                builder: (_) => _reviewsStore.reviews.isNotEmpty
                    ? SafeArea(
                        child: CustomScrollView(
                            controller: scrollController,
                            slivers: <Widget>[
                            _summaryHeader(
                                _reviewsStore,
                                HeaderTypeEnum.HeaderTypeFull,
                                scrollController),
                            _summaryHeader(
                                _reviewsStore,
                                HeaderTypeEnum.HeaderTypeSimple,
                                scrollController),
                            _reviewList(),
                          ]))
                    : _emptyReviewIndicator())),
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
        ));
  }

  _reviewList() {
    return SliverPadding(
        padding: const EdgeInsets.all(5.0),
        sliver: SliverFixedExtentList(
            itemExtent: 56.0,
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
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
                      if (direction == DismissDirection.endToStart ||
                          direction == DismissDirection.startToEnd) {
                        _reviewsStore.removeReview(thisReview.uniqueKey);
                      }
                    },
                  ),
                  onLongPress: () {
                    // you can show an AlertDialog here with 3 options you need
                    var bottomSheetController = showModalBottomSheet(
                        // If your BottomSheetModel is Column make sure you add mainAxisSize: MainAxisSize.min, otherwise the sheet will cover the whole screen.
                        isScrollControlled: true, // allow for keyboard
                        context: context,
                        builder: (BuildContext context) {
                          return ReviewMod(_submitReview, thisReview);
                        });
                    bottomSheetController
                        .whenComplete(() => null)
                        .then((value) {});
                  },
                ),
              );
            }, childCount: _reviewsStore.reviews.length)));
  }

  _summaryHeader(Reviews reviewStore, HeaderTypeEnum headerType,
      ScrollController scrollController) {
    return SliverPersistentHeader(
        pinned: headerType == HeaderTypeEnum.HeaderTypeFull ? false : true,
        floating: headerType == HeaderTypeEnum.HeaderTypeFull ? true : false,
        delegate: _SliverPersistentHeaderSummaryDelegate(
            reviewStore: reviewStore,
            headerType: headerType,
            scrollController: scrollController));
  }

  _emptyReviewIndicator() {
    return Container(child: Text("empty"));
  }
}

class _SliverPersistentHeaderSummaryDelegate
    extends SliverPersistentHeaderDelegate {
  final Reviews reviewStore;
  final HeaderTypeEnum headerType;
  final ScrollController scrollController;

  String get _numberOfReviews {
    return reviewStore == null ? "0" : reviewStore.numberOfReviews.toString();
  }

  String get _averageStars {
    return reviewStore == null
        ? "0.0"
        : //reviewStore.averageStars.then((val) {
        // val.toStringAsFixed(2);
        //}) as String;
        reviewStore.averageStars.toStringAsFixed(2);
  }

  _SliverPersistentHeaderSummaryDelegate(
      {@required this.reviewStore,
      @required this.headerType,
      @required this.scrollController});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return headerType == HeaderTypeEnum.HeaderTypeFull
        ? PreferredSize(
            preferredSize: Size.fromHeight(this.maxExtent),
            child: Container(
              color: Colors.white,
              child: ClipRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: OverflowBox(
                  maxHeight: 106,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 6.0),
                        //contains average stars and total reviews card
                        Flexible(
                            child: FittedBox(
                          fit: BoxFit.none,
                          child: Observer(
                            builder: (_) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  InfoCard(
                                      infoValue: _numberOfReviews,
                                      infoLabel: "reviews",
                                      cardColor: Colors.green,
                                      iconData: Icons.comment),
                                  InfoCard(
                                    infoValue: _averageStars,
                                    infoLabel: "average stars",
                                    cardColor: Colors.lightBlue,
                                    iconData: Icons.star,
                                    key: Key('avgStar'),
                                  ),
                                ],
                              );
                            },
                          ),
                        ))
                      ]),
                ),
              ),
            ))
        : PreferredSize(
            preferredSize: Size.fromHeight(this.maxExtent),
            child: Container(
              color: Colors.white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 6.0),
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
                    )
                  ]),
            ));
  }

  @override
  double get maxExtent => headerType == HeaderTypeEnum.HeaderTypeFull
      ? 106
      : 50; //child.preferredSize.height;

  @override
  double get minExtent => headerType == HeaderTypeEnum.HeaderTypeFull
      ? 68
      : 50; //child.preferredSize.height / 2;

  @override
  bool shouldRebuild(_SliverPersistentHeaderSummaryDelegate oldDelegate) {
    return false;
  }
}
