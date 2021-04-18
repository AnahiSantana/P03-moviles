import 'package:equatable/equatable.dart';

import 'new.dart';

class News extends Equatable {
  final String status;
  final int totalResults;
  final List<New> newsList;

  const News({
    this.status,
    this.totalResults,
    this.newsList,
  });

  @override
  String toString() {
    return 'News(status: $status, totalResults: $totalResults, articles: $newsList)';
  }

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      status: json['status'] as String,
      totalResults: json['totalResults'] as int,
      newsList: (json['articles'] as List)
          ?.map((e) => e == null
              ? null
              : New.fromJson(json['articles'] as Map<String, dynamic>))
          ?.toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'articles': newsList?.map((e) => e?.toJson())?.toList(),
    };
  }

  News copyWith({
    String status,
    int totalResults,
    List<New> newsList,
  }) {
    return News(
      status: status ?? this.status,
      totalResults: totalResults ?? this.totalResults,
      newsList: newsList ?? this.newsList,
    );
  }

  @override
  List<Object> get props => [status, totalResults, newsList];
}
