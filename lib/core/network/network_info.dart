import 'package:connectivity_plus/connectivity_plus.dart';

// For checking internet connectivity
abstract class NetworkInfoI {
  Future<bool> isConnected();

  Future<ConnectivityResult> get connectivityResult;

  Stream<ConnectivityResult> get onConnectivityChanged;
}

class NetworkInfo implements NetworkInfoI {
  Connectivity connectivity;

  static final NetworkInfo _networkInfo = NetworkInfo._internal(Connectivity());

  factory NetworkInfo() {
    return _networkInfo;
  }

  NetworkInfo._internal(this.connectivity) {
    connectivity = connectivity;
  }

  Future<ConnectivityResult> getConnectivityResult() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return ConnectivityResult.mobile;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return ConnectivityResult.wifi;
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      return ConnectivityResult.ethernet;
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      return ConnectivityResult.vpn;
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      return ConnectivityResult.bluetooth;
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      return ConnectivityResult.other;
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      return ConnectivityResult.none;
    } else {
      // Default case, return none if none of the above conditions are met
      return ConnectivityResult.none;
    }
  }

  ///checks internet is connected or not
  ///returns [true] if internet is connected
  ///else it will return [false]
  @override
  Future<bool> isConnected() async {
    final result = await getConnectivityResult();
    return result != ConnectivityResult.none;
  }

  // to check type of internet connectivity
  @override
  Future<ConnectivityResult> get connectivityResult async {
    return await getConnectivityResult();
  }

  @override
  // TODO: implement onConnectivityChanged
  Stream<ConnectivityResult> get onConnectivityChanged =>
      connectivity.onConnectivityChanged.expand((results) => results);
}

abstract class Failure {}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NetworkFailure extends Failure {}

class ServerException implements Exception {}

class CacheException implements Exception {}

class NetworkException implements Exception {}

///can be used for throwing [NoInternetException]
class NoInternetException implements Exception {
  late String _message;

  NoInternetException([String message = 'NoInternetException Occurred']) {
    _message = message;
  }

  @override
  String toString() {
    return _message;
  }
}
