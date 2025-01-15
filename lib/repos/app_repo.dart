import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:society_management/models/result.dart';
import '../datasource/app_data_source.dart';
import '../core/error/dio_custom_error.dart';

class AppRepository {
  final _appDataSource = Get.find<AppDataSource>();

  Future<Either<Failure, List<Map<String, dynamic>>>> getDashboardData() async {
    try {
      var res = await _appDataSource.getDashboardData();
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> getAppartments() async {
    try {
      var res = await _appDataSource.getAppartments();
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> getDesignations() async {
    try {
      var res = await _appDataSource.getDesignations();
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> getSubusers() async {
    try {
      var res = await _appDataSource.getSubusers();
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> getResidentTypes() async {
    try {
      var res = await _appDataSource.getResidentTypes();
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> getVisitors(data) async {
    try {
      var res = await _appDataSource.getVisitorList(data);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> getRequestDetails(
      {String? token, int? id}) async {
    try {
      var res = await _appDataSource.getRequestDetails(token: token, id: id);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>>
      getResidentDashboardData() async {
    try {
      var res = await _appDataSource.getResidentDashboardData();
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> getTodaysVisitors(
      data) async {
    try {
      var res = await _appDataSource.getTodaysVisitors(data);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, List<String>>> uploadFiles(List<File> files) async {
    try {
      var res = await _appDataSource.uploadFiles(files);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, Result>> addVisitorRequest(data) async {
    try {
      var res = await _appDataSource.addVisitorRequest(data);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, Result>> updateProfile(data) async {
    try {
      var res = await _appDataSource.updateProfile(data);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, Result>> addSubuser(data) async {
    try {
      var res = await _appDataSource.addSubuser(data);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, Result>> statusChange(data) async {
    try {
      var res = await _appDataSource.statusChange(data);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> addFirebaseToken(dynamic data) async {
    try {
      var res = await _appDataSource.addFirebaseToken(data);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, bool>> deleteAccount(reason) async {
    try {
      var res = await _appDataSource.deleteAccount(reason);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, bool>> removeFirebaseToken(token) async {
    try {
      var res = await _appDataSource.removeFirebaseToken(token);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, Result>> upadatePassword(oldPass, newPass) async {
    try {
      var res = await _appDataSource.upadatePassword(oldPass, newPass);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> getCategories(
      type, parentId) async {
    try {
      var res = await _appDataSource.getCategories(type, parentId);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> getSettingDDL(
      type) async {
    try {
      var res = await _appDataSource.getSettingDDL(type);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> getRequests(data) async {
    try {
      var res = await _appDataSource.getRequests(data);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, Result>> addRequest(data) async {
    try {
      var res = await _appDataSource.addRequest(data);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, Result>> updateRequestStatus(data) async {
    try {
      var res = await _appDataSource.updateRequestStatus(data);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, String>> getTermsNConditions(type) async {
    try {
      var res = await _appDataSource.getTermsNConditions(type);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, Result>> activeDeactiveUser(id, isActive) async {
    try {
      var res = await _appDataSource.activeDeactiveUser(id, isActive);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>>
      getUserAppartments() async {
    try {
      var res = await _appDataSource.getUserAppartments();
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, Map>> getIsUserActive(version, buildNum) async {
    try {
      var res = await _appDataSource.getIsUserActive(version, buildNum);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }
}
