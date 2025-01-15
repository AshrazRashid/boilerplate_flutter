import 'dart:io';
import 'package:dio/dio.dart';
import 'package:society_management/constants/enums.dart';
import 'package:society_management/core/error/dio_custom_error.dart';
import 'package:society_management/models/result.dart';
import 'package:society_management/services/api_service.dart';
import 'package:society_management/utils/api_url_utils.dart';

abstract class AppDataSource {
  Future<List<String>> uploadFiles(List<File> files);
  Future<Result> addVisitorRequest(Map<String, dynamic> data);
  Future<List<Map<String, dynamic>>> getDashboardData();
  Future<Map<String, dynamic>> getRequestDetails({String? token, int? id});
  Future<Map<String, dynamic>> getResidentDashboardData();
  Future<List<Map<String, dynamic>>> getAppartments();
  Future<List<Map<String, dynamic>>> getDesignations();
  Future<List<Map<String, dynamic>>> getSubusers();
  Future<Result> addSubuser(Map<String, dynamic> data);
  Future<Result> updateProfile(Map<String, dynamic> data);
  Future<Result> statusChange(data);
  Future<List<Map<String, dynamic>>> getResidentTypes();
  Future<List<Map<String, dynamic>>> getVisitorList(data);
  Future<List<Map<String, dynamic>>> getTodaysVisitors(data);
  Future<void> addFirebaseToken(dynamic data);
  Future<bool> deleteAccount(reason);
  Future<bool> removeFirebaseToken(token);
  Future<Result> upadatePassword(oldPass, newPass);
  Future<List<Map<String, dynamic>>> getCategories(type, parentId);
  Future<Map<String, dynamic>> getRequests(data);
  Future<Result> addRequest(data);
  Future<Result> updateRequestStatus(data);
  Future<List<Map<String, dynamic>>> getSettingDDL(type);
  Future<List<Map<String, dynamic>>> getUserAppartments();
  Future<String> getTermsNConditions(type);
  Future<Result> activeDeactiveUser(id, isActive);
  Future<Map> getIsUserActive(String version, String buildNumber);
}

class AppDataSourceImpl extends AppDataSource {
  final Dio dio = getDio();

  @override
  Future<void> addFirebaseToken(data) async {
    try {
      await dio.post(
          ApiUrlUtils.getApiUrl(
            UrlEndPointEnum.addFirebaseToken,
          ),
          data: data);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<List<String>> uploadFiles(List<File> files) async {
    try {
      // String fileName = file.path.split('/').last;
      // FormData formData = FormData.fromMap({
      //   "files": [await MultipartFile.fromFile(file.path, filename: fileName)],
      // });
      List<MultipartFile> multipartFiles = [];

      for (File file in files) {
        String fileName = file.path.split('/').last;
        MultipartFile multipartFile = await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        );
        multipartFiles.add(multipartFile);
      }

      // Prepare FormData with the list of files
      FormData formData = FormData.fromMap({
        "files": multipartFiles,
      });
      var res = await dio.post(
        ApiUrlUtils.getApiUrl(UrlEndPointEnum.uploadImage),
        data: formData,
      );
      if (res.data['status'] == 1 &&
          res.data['data'] != null &&
          res.data['data'].isNotEmpty) {
        return List<Map<String, dynamic>>.from(res.data['data'])
            .map<String>((e) => e['photo'])
            .toList();
      } else {
        throw DioCustomError(errorMessage: res.data['message']);
      }
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<Result> addVisitorRequest(Map<String, dynamic> data) async {
    try {
      var res = await dio.post(
        ApiUrlUtils.getApiUrl(UrlEndPointEnum.addVisitorRequest),
        data: data,
      );
      return res.data['status'] == 1
          ? Result.fromJson(res.data as Map<String, dynamic>)
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<Result> statusChange(data) async {
    try {
      var res = await dio.post(
        ApiUrlUtils.getApiUrl(UrlEndPointEnum.changeStatus),
        data: data,
      );
      return res.data['status'] == 1
          ? Result.fromJson(res.data as Map<String, dynamic>)
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getDashboardData() async {
    try {
      var res = await dio.get(
        ApiUrlUtils.getApiUrl(UrlEndPointEnum.dashboard),
      );
      return res.data['status'] == 1 && res.data['data'] != null
          ? (res.data['data'] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList()
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getRequestDetails(
      {String? token, int? id}) async {
    try {
      var res = await dio.post(
          ApiUrlUtils.getApiUrl(UrlEndPointEnum.requestDetails),
          queryParameters: token != null ? {"token": token} : {"id": id});
      return res.data['status'] == 1 &&
              res.data['data'] != null &&
              res.data['data'].isNotEmpty
          ? (res.data['data'][0] as Map<String, dynamic>)
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getResidentDashboardData() async {
    try {
      var res = await dio.get(
        ApiUrlUtils.getApiUrl(UrlEndPointEnum.residentDashboardData),
      );
      return res.data['status'] == 1 && res.data['data'] != null
          ? (res.data['data'])[0] as Map<String, dynamic>
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAppartments() async {
    try {
      var res = await dio.get(
        ApiUrlUtils.getApiUrl(UrlEndPointEnum.apartmentList),
      );
      return res.data['status'] == 1 && res.data['data'] != null
          ? (res.data['data'] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList()
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getDesignations() async {
    try {
      var res = await dio.get(
        ApiUrlUtils.getApiUrl(UrlEndPointEnum.designationList),
      );
      return res.data['status'] == 1 && res.data['data'] != null
          ? (res.data['data'] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList()
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getSubusers() async {
    try {
      var res = await dio.get(
        ApiUrlUtils.getApiUrl(UrlEndPointEnum.getSubusers),
      );
      return res.data['status'] == 1 && res.data['data'] != null
          ? (res.data['data'] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList()
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<Result> addSubuser(Map<String, dynamic> data) async {
    try {
      var res = await dio.post(
        ApiUrlUtils.getApiUrl(UrlEndPointEnum.registerSubuser),
        data: data,
      );
      return res.data['status'] == 1
          ? Result.fromJson(res.data as Map<String, dynamic>)
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<Result> updateProfile(Map<String, dynamic> data) async {
    try {
      var res = await dio.post(
        ApiUrlUtils.getApiUrl(UrlEndPointEnum.updateProfile),
        data: data,
      );
      return res.data['status'] == 1
          ? Result.fromJson(res.data as Map<String, dynamic>)
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getResidentTypes() async {
    try {
      var res = await dio.get(
        ApiUrlUtils.getApiUrl(UrlEndPointEnum.residentTypes),
        options: Options(validateStatus: (status) {
          // Allow status codes 200 and 307 to pass without throwing an exception
          return status! < 300 || status == 307;
        }),
      );
      if (res.statusCode == 307) {
        final newUrl = res.headers['location']?.first;
        if (newUrl != null) {
          res = await dio.get(newUrl);
        }
      }
      return res.data['status'] == 1 && res.data['data'] != null
          ? (res.data['data'] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList()
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getVisitorList(data) async {
    try {
      var res = await dio
          .post(ApiUrlUtils.getApiUrl(UrlEndPointEnum.visitorList), data: data);
      return res.data['status'] == 1 && res.data['data'] != null
          ? (res.data['data'] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList()
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getTodaysVisitors(data) async {
    try {
      var res = await dio.post(
          ApiUrlUtils.getApiUrl(UrlEndPointEnum.todaysVisitors),
          data: data);
      return res.data['status'] == 1 && res.data['data'] != null
          ? (res.data['data'] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList()
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<bool> deleteAccount(reason) async {
    try {
      var res = await dio.post(
        ApiUrlUtils.getApiUrl(UrlEndPointEnum.deleteAccount, id: reason),
      );
      return res.data['status'] == 1
          ? true
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<bool> removeFirebaseToken(token) async {
    try {
      var res = await dio.delete(ApiUrlUtils.getApiUrl(
          UrlEndPointEnum.removeFirebaseToken,
          id: token));
      return res.data['status'] == 1
          ? true
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<Result> upadatePassword(oldPass, newPass) async {
    try {
      var res = await dio.post("${ApiUrlUtils.getApiUrl(
        UrlEndPointEnum.changePassword,
      )}?CurrentPassword=$oldPass&NewPassword=$newPass");
      return res.data['status'] == 1
          ? Result.fromJson(res.data as Map<String, dynamic>)
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getCategories(type, parentId) async {
    try {
      var queryParameters = 'type=$type';
      if (parentId != null) {
        queryParameters += "&parentId=$parentId";
      }
      var res = await dio.get(
        "${ApiUrlUtils.getApiUrl(UrlEndPointEnum.categories)}?$queryParameters",
      );
      return res.data['status'] == 1 && res.data['data'] != null
          ? (res.data['data'] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList()
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getSettingDDL(type) async {
    try {
      var res = await dio.get(
        "${ApiUrlUtils.getApiUrl(UrlEndPointEnum.getSettingDDL)}?type=$type",
      );
      return res.data['status'] == 1 && res.data['data'] != null
          ? (res.data['data'] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList()
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<Result> addRequest(data) async {
    try {
      var res = await dio.post(
        ApiUrlUtils.getApiUrl(UrlEndPointEnum.addRequest),
        data: data,
      );
      return res.data['status'] == 1
          ? Result.fromJson(res.data as Map<String, dynamic>)
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getRequests(data) async {
    try {
      var res = await dio
          .post(ApiUrlUtils.getApiUrl(UrlEndPointEnum.getRequests), data: data);
      return res.data['status'] == 1 &&
              res.data['data'] != null &&
              res.data['data'].isNotEmpty
          ? (res.data['data'][0] as Map<String, dynamic>)
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<Result> updateRequestStatus(data) async {
    try {
      var res = await dio.post(
        ApiUrlUtils.getApiUrl(UrlEndPointEnum.updateRequestStatus),
        data: data,
      );
      return res.data['status'] == 1
          ? Result.fromJson(res.data as Map<String, dynamic>)
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<String> getTermsNConditions(type) async {
    try {
      var res = await dio.get(
        "${ApiUrlUtils.getApiUrl(UrlEndPointEnum.termsNConditions)}?type=$type",
      );
      return res.data['status'] == 1
          ? (res.data['data'][0] as Map<String, dynamic>)['condition']
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<Result> activeDeactiveUser(id, isActive) async {
    try {
      var res = await dio.post(
        "${ApiUrlUtils.getApiUrl(UrlEndPointEnum.activeDeactiveUser)}?id=$id&isActive=$isActive",
      );
      return res.data['status'] == 1
          ? Result.fromJson(res.data as Map<String, dynamic>)
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getUserAppartments() async {
    try {
      var res = await dio.get(
        ApiUrlUtils.getApiUrl(UrlEndPointEnum.userAppartments),
      );
      return res.data['status'] == 1 && res.data['data'] != null
          ? List<Map<String, dynamic>>.from(res.data['data'])
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<Map> getIsUserActive(String version, String buildNumber) async {
    var dio = getDio();
    try {
      var res = await dio.post(
          ApiUrlUtils.getApiUrl(UrlEndPointEnum.isUserActive),
          queryParameters: {
            "appVersionNumber": version,
            "appBuiltNumber": buildNumber
          });
      return res.data;
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }
}
