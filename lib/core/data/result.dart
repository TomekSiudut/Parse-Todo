import 'package:freezed_annotation/freezed_annotation.dart';
part 'result.freezed.dart';

@freezed
abstract class Result<T> with _$Result {
  const factory Result() = Data;

  const factory Result.loading() = Loading;

  const factory Result.initial() = Initial;

  const factory Result.error(String? message) = ErrorDetails;

  const factory Result.success(T? data) = Success;
}
