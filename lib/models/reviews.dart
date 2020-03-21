import 'dart:async';
import 'dart:convert';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './reviewmodel.dart';
part 'reviews.g.dart';

class Reviews = ReviewsBase with _$Reviews;

abstract class ReviewsBase with Store {
  @observable
  ObservableList<ReviewModel> reviews = ObservableList.of([]);

  @computed
  double get averageStars {
    return totalStars / numberOfReviews;
  }

  @computed
  int get numberOfReviews => reviews.length;

  @computed
  int get totalStars {
    //return reviews.reduce((x, y) => x.stars + y.stars)
    int value = reviews.first.stars;
    reviews.skip(1).forEach((element) {
      value = value + element.stars;
    });
    return value;
  }

  @action
  void addReview(ReviewModel newReview) {
    //to update list of reviews
    reviews.add(newReview);

    // to store the reviews using Shared Preferences
    _persistReview(reviews);
  }

  @action
  Future<void> initReviews() async {
    await _getReviews().then((onValue) {
      reviews = ObservableList.of(onValue);
    });
  }

  @action
  void removeReview(String uniqueKey) {
    var thisModel =
        reviews.where((element) => element.uniqueKey == uniqueKey).first;
    //to update list of reviews
    reviews.removeWhere((element) => element.uniqueKey == uniqueKey);
 
    // to store the reviews using Shared Preferences
    _persistReview(reviews);
  }

  @action
  void updateReview(ReviewModel reviewModel) {
    var index = reviews
        .indexWhere((element) => element.uniqueKey == reviewModel.uniqueKey);
    if (index != -1) {
      int currentStars = reviews[index].stars;
      //to update list of reviews
      reviews[index] = reviewModel;
      // to store the reviews using Shared Preferences
      _persistReview(reviews);
    }
  }

  void _persistReview(List<ReviewModel> updatedReviews) async {
    List<String> reviewsStringList = [];
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    for (ReviewModel review in updatedReviews) {
      Map<String, dynamic> reviewMap = review.toJson();
      String reviewString = jsonEncode(ReviewModel.fromJson(reviewMap));
      reviewsStringList.add(reviewString);
    }
    _preferences.setStringList('userReviews', reviewsStringList);
  }

  Future<List<ReviewModel>> _getReviews() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    final List<String> reviewsStringList =
        _preferences.getStringList('userReviews') ?? [];
    final List<ReviewModel> retrievedReviews = [];
    for (String reviewString in reviewsStringList) {
      Map<String, dynamic> reviewMap = jsonDecode(reviewString);
      ReviewModel review = ReviewModel.fromJson(reviewMap);
      retrievedReviews.add(review);
    }
    return retrievedReviews;
  }
}
