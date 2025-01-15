import '../constants/enums.dart';

class ApiUrlUtils {
  static String getApiUrl(UrlEndPointEnum urlEndPoint, {dynamic id}) {
    switch (urlEndPoint) {
      case UrlEndPointEnum.signin:
        return '/SignIn';

      default:
        return '';
    }
  }
}
