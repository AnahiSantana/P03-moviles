import 'package:equatable/equatable.dart';

import "articles.dart";

class Noticias extends Equatable {
  final String status;
  final int totalResults;
  final List<Articles> articles;

  const Noticias({
    this.status,
    this.totalResults,
    this.articles,
  });

  @override
  String toString() {
    return 'Noticias(status: $status, totalResults: $totalResults, articles: $articles)';
  }

  factory Noticias.fromJson(Map<String, dynamic> json) {
    return Noticias(
      status: json['status'] as String,
      totalResults: json['totalResults'] as int,
      articles: (json['articles'] as List)
          ?.map((e) => e == null
              ? null
              : Articles.fromJson(json['articles'] as Map<String, dynamic>))
          ?.toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'articles': articles?.map((e) => e?.toJson())?.toList(),
    };
  }

  Noticias copyWith({
    String status,
    int totalResults,
    List<Articles> articles,
  }) {
    return Noticias(
      status: status ?? this.status,
      totalResults: totalResults ?? this.totalResults,
      articles: articles ?? this.articles,
    );
  }

  @override
  List<Object> get props => [status, totalResults, articles];
}
