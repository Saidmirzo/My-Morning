import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionRepo {
  static Future<bool> isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    bool result = (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi);
    return result;
  }
}
