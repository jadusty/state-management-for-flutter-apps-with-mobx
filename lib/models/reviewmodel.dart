import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class ReviewModel {
  final String uniqueKey = Uuid().v1();
  final String comment;
  final int stars;
  ReviewModel({@required this.comment, @required this.stars});

  factory ReviewModel.fromJson(Map<String, dynamic> parsedJson) {
    return ReviewModel(
      comment: parsedJson['comment'],
      stars: parsedJson['stars'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'comment': this.comment,
      'stars': this.stars,
    };
  }
}