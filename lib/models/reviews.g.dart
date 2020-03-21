// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Reviews on ReviewsBase, Store {
  Computed<double> _$averageStarsComputed;

  @override
  double get averageStars =>
      (_$averageStarsComputed ??= Computed<double>(() => super.averageStars))
          .value;
  Computed<int> _$numberOfReviewsComputed;

  @override
  int get numberOfReviews =>
      (_$numberOfReviewsComputed ??= Computed<int>(() => super.numberOfReviews))
          .value;
  Computed<int> _$totalStarsComputed;

  @override
  int get totalStars =>
      (_$totalStarsComputed ??= Computed<int>(() => super.totalStars)).value;

  final _$reviewsAtom = Atom(name: 'ReviewsBase.reviews');

  @override
  ObservableList<ReviewModel> get reviews {
    _$reviewsAtom.context.enforceReadPolicy(_$reviewsAtom);
    _$reviewsAtom.reportObserved();
    return super.reviews;
  }

  @override
  set reviews(ObservableList<ReviewModel> value) {
    _$reviewsAtom.context.conditionallyRunInAction(() {
      super.reviews = value;
      _$reviewsAtom.reportChanged();
    }, _$reviewsAtom, name: '${_$reviewsAtom.name}_set');
  }

  final _$initReviewsAsyncAction = AsyncAction('initReviews');

  @override
  Future<void> initReviews() {
    return _$initReviewsAsyncAction.run(() => super.initReviews());
  }

  final _$ReviewsBaseActionController = ActionController(name: 'ReviewsBase');

  @override
  void addReview(ReviewModel newReview) {
    final _$actionInfo = _$ReviewsBaseActionController.startAction();
    try {
      return super.addReview(newReview);
    } finally {
      _$ReviewsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeReview(String uniqueKey) {
    final _$actionInfo = _$ReviewsBaseActionController.startAction();
    try {
      return super.removeReview(uniqueKey);
    } finally {
      _$ReviewsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateReview(ReviewModel reviewModel) {
    final _$actionInfo = _$ReviewsBaseActionController.startAction();
    try {
      return super.updateReview(reviewModel);
    } finally {
      _$ReviewsBaseActionController.endAction(_$actionInfo);
    }
  }
}
