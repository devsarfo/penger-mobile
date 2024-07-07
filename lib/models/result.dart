import 'dart:collection';

import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Result<T> {
  final bool isSuccess;
  final String message;
  T? results;
  Map<String, dynamic>? errors;

  Result({required this.isSuccess, required this.message, this.results, this.errors});

  /// Connect the generated [_$ResultFromJson] function to the `fromJson`
  /// factory.
  factory Result.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$ResultFromJson(json, fromJsonT);

  /// Connect the generated [_$ResultToJson] function to the `toJson` method.
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$ResultToJson(this, toJsonT);
}