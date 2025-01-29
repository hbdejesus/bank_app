import 'package:freezed_annotation/freezed_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime?, String?> {
  const DateTimeConverter();

  @override
  DateTime? fromJson(String? json) => json != null ? DateTime.parse(json) : null;

  @override
  String? toJson(DateTime? json) => json?.toString();
}
