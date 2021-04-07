import 'package:equatable/equatable.dart';

class Source extends Equatable {
  final dynamic id;
  final String name;

  const Source({this.id, this.name});

  @override
  String toString() => 'Source(id: $id, name: $name)';

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] as dynamic,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  Source copyWith({
    dynamic id,
    String name,
  }) {
    return Source(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object> get props => [id, name];
}
