import 'package:flutter/material.dart';
import 'package:society_management/services/app_preferences.dart';
import 'package:society_management/theme/app_colors.dart';

enum EnvironmentEnum {
  dev,
  uat,
  prod,
}

enum RoleEnum {
  superAdmin(1),
  admin(2),
  residential(3),
  residentialChild(4),
  securityGuard(19);

  const RoleEnum(this.value);
  final int value;

  static bool isSG() =>
      AppPreferences.getLogin()!.roleId == securityGuard.value;
}

enum StartPageType { sportsSelection, gettingStarted }

enum UrlEndPointEnum {
  signin,
  register,
  dashboard,
  apartmentList,
  residentTypes,
  designationList,
  addVisitorRequest,
  visitorList,
  todaysVisitors,
  getSubusers,
  registerSubuser,
  updateProfile,
  uploadImage,
  requestDetails,
  residentDashboardData,
  changeStatus,
  addFirebaseToken,
  deleteAccount,
  removeFirebaseToken,
  changePassword,
  forgotPassword,
  categories,
  getRequests,
  addRequest,
  updateRequestStatus,
  getSettingDDL,
  termsNConditions,
  activeDeactiveUser,
  userAppartments,
  isUserActive
}

enum VisitingTypeEnum {
  guest(1),
  driver(2),
  plumber(3),
  electrician(4),
  funeral(5),
  deliveryPerson(10);

  const VisitingTypeEnum(this.value);
  final int value;

  static VisitingTypeEnum getType(int value) =>
      VisitingTypeEnum.values.firstWhere(
        (e) => e.value == value,
        orElse: () => VisitingTypeEnum.guest,
      );

  static String getName(VisitingTypeEnum type) {
    switch (type) {
      case VisitingTypeEnum.guest:
        return "Guest";
      case VisitingTypeEnum.driver:
        return "Driver";
      case VisitingTypeEnum.plumber:
        return "Plumber";
      case VisitingTypeEnum.electrician:
        return "Electrician";
      case VisitingTypeEnum.funeral:
        return "For Funeral";
      case VisitingTypeEnum.deliveryPerson:
        return "Delivery Person";
      default:
        return "Unknown";
    }
  }
}

enum StatusEnum {
  initiated(1),
  rejected(2),
  checkedOut(3),
  cancelled(4),
  pending(5),
  checkedIn(6);

  const StatusEnum(this.value);
  final int value;

  static String getStatus(int value) {
    StatusEnum? status = StatusEnum.values.firstWhere(
      (e) => e.value == value,
      orElse: () => StatusEnum.initiated,
    );
    switch (status) {
      case StatusEnum.initiated:
        return "New Request";
      case StatusEnum.rejected:
        return "Rejected";
      case StatusEnum.checkedOut:
        return "Checked out";
      case StatusEnum.cancelled:
        return "Cancelled";
      case StatusEnum.pending:
        return "Pending";
      case StatusEnum.checkedIn:
        return "Checked in";
      default:
        return "Unknown Status";
    }
  }

  static Color getStatusColor(int value) {
    StatusEnum? status = StatusEnum.values.firstWhere(
      (e) => e.value == value,
      orElse: () => StatusEnum.initiated,
    );
    switch (status) {
      case StatusEnum.initiated:
        return Colors.amber;
      case StatusEnum.rejected:
        return Colors.redAccent;
      case StatusEnum.checkedOut:
        return Colors.green;
      case StatusEnum.cancelled:
        return Colors.red;
      case StatusEnum.pending:
        return Colors.grey;
      case StatusEnum.checkedIn:
        return AppColors.primary;
      default:
        return Colors.amber;
    }
  }
}

enum ApartmentTypeEnum {
  banglow(1),
  shop(2),
  house(3),
  apartment(4);

  const ApartmentTypeEnum(this.value);
  final int value;

  static String getAppartmentName(int? value) {
    ApartmentTypeEnum? apptName = ApartmentTypeEnum.values.firstWhere(
      (e) => e.value == value,
      orElse: () => ApartmentTypeEnum.banglow,
    );

    switch (apptName) {
      case ApartmentTypeEnum.shop:
        return "Shop";
      case ApartmentTypeEnum.house:
        return "House";
      case ApartmentTypeEnum.apartment:
        return "Appartment";
      case ApartmentTypeEnum.banglow:
      default:
        return "Banglow";
    }
  }
}

enum NotificationTypeEnum {
  guestCheckIn(1),
  requestRejectedByAdmin(2),
  cancelledRejectedByAdmin(3),
  guestCheckOutFromSociety(4);

  const NotificationTypeEnum(this.value);
  final int value;
}

enum VerificationTypeEnum {
  accountVerificationPhone(1),
  forgotPassword(2);

  const VerificationTypeEnum(this.value);
  final int value;
}

enum CategoryTypeEnum {
  parentCategory(1),
  childCategory(2),
  faults(3);

  const CategoryTypeEnum(this.value);
  final int value;
}

enum PaymentType { partial, full }

enum ServiceRequestStatusEnum {
  pending(0),
  inProgress(1),
  cancelled(2), // by user
  rejected(3), //by admin
  completed(4);

  const ServiceRequestStatusEnum(this.value);
  final int value;
}

enum SettingDDLEnum {
  visitorDeposit(1),
  subUserRelationship(2);

  const SettingDDLEnum(this.value);
  final int value;
}

enum TermAndConditionEnum {
  visitorEntrance(1);

  const TermAndConditionEnum(this.value);
  final int value;
}

enum DocumentEnum {
  airBnb(1);

  const DocumentEnum(this.value);
  final int value;
}

enum UploadAllowedTypes { camera, gallery, pdf }
