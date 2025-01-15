import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:society_management/datasource/auth_datasource.dart';
import 'package:society_management/models/login.dart';
import 'package:society_management/models/result.dart';
import '../core/error/dio_custom_error.dart';

class AuthRepository {
  final _authDataSource = Get.find<AuthDataSource>();

  Future<Either<Failure, Login?>> login(Map<String, dynamic> data) async {
    try {
      var res = await _authDataSource.login(data);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, String>> signup(Map<String, dynamic> data) async {
    try {
      var res = await _authDataSource.createUser(data: data);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failure, Result>> forgotPassword(cnic) async {
    try {
      var res = await _authDataSource.forgotPassword(cnic);
      return Right(res);
    } catch (e) {
      return Left(DioCustomError(errorMessage: e.toString()));
    }
  }
}
