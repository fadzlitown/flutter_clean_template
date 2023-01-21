import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

//TODO why not directly call from REPO IMPLEMENTATION ?
// Remember the single source, reuse to other REPO & seperation for testable code
class NetworkInfoImpl implements NetworkInfo{
  InternetConnectionChecker internetConnectionChecker;

  NetworkInfoImpl(this.internetConnectionChecker);

  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;
  //TODO that implemented abstract override isConnected method will be referring to this internetConnectionChecker.hasConnection came from library

  //same like this approach
  // Future<bool> get isConnected {
  //   internetConnectionChecker.hasConnection;
  //   return Future.value(true);
  // }

}
