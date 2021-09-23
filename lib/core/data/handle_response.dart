import 'dart:io';
import 'package:dio/dio.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:todo/core/data/result.dart';

typedef Future Callback();

Future<Result<List<Entity>?>> responseResultList<Entity, Type>(
    Callback callback,
    {Entity Function(Type)? mapToEntity}) async {
  try {
    ParseResponse response = await callback();
    if (response.success && response.results != null) {
      try {
        List? objects = response.results;
        List<Entity>? entities = [];

        if (mapToEntity != null) {
          entities = objects?.map((e) => mapToEntity(e)).toList();
          print(entities);
        }
        return Result.success(entities);
      } catch (e) {
        return Result.error("Object not found!");
      }
    } else if (response.error != null) {
      if (response.error!.exception is SocketException) {
        return Result.error('No Internet connection.');
      }
      return Result.error(response.error!.message);
    }
  } on DioError catch (e) {
    if (e.response?.data != null)
      return Result.error(e.response?.data['message']);
    print("Exception: $e");
  } catch (e, stacktrace) {
    print("Exception: $e, stacktrace: $stacktrace");
    return Result.error("Something went wrong.");
  }
  return Result.error("Something went wrong.");
}

Future<Result> responseResult<Entity, Type>(
  Callback callback, {
  Entity Function(Type)? mapToEntity,
}) async {
  try {
    ParseResponse response = await callback();
    if (response.success && response.results != null) {
      try {
        Type object = response.results!.first;
        Entity? entity;
        if (mapToEntity != null) {
          entity = mapToEntity(object);
          return Result.success(entity);
        }
        return Result.success(object);
      } catch (e) {
        return Result.error("Object not found!");
      }
    } else if (response.error != null) {
      if (response.error!.exception is SocketException) {
        return Result.error('No Internet connection.');
      }
      return Result.error(response.error!.message);
    }
  } on DioError catch (e) {
    if (e.response?.data != null)
      return Result.error(e.response?.data['message']);
    print("Exception: $e");
  } catch (e, stacktrace) {
    print("Exception: $e, stacktrace: $stacktrace");
    return Result.error("Something went wrong.");
  }
  return Result.error("Something went wrong.");
}
