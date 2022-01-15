import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9452036756235787/1250656891';
      // } else if (Platform.isIOS) {
      //   return '';
    } else {
      throw UnsupportedError("unsupported Platform");
    }
  }
}
