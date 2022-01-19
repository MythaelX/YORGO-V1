import 'package:intl/intl.dart';

String? getImageUser(String? image) {
  if (image != null &&
      image != "media/default_profile_image.png" &&
      image != "/media/") {
    return "http://yorgoapi.herokuapp.com" + image;
  } else {
    return null;
  }
}

String? getImageUser2(String? image) {
  if (image != null &&
      image != "" &&
      image != "media/default_profile_image.png") {
    return "http://yorgoapi.herokuapp.com/media/" + image;
  } else {
    return null;
  }
}

double? getDouble(String? value) {
  try {
    if (value != null) {
      return double.parse(value);
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

int? getInt(String? value) {
  try {
    if (value != null) {
      return int.parse(value);
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

getBoolfromString(String? string) {
  if (string == "True") {
    return true;
  } else {
    return false;
  }
}

getDateTimeFromString(String string) {
  return DateTime.parse(string);
}

DateTime? getDateAndTime(String? date) {
  try {
    if (date != null) {
      return DateFormat('yyyy/MM/dd HH:mm:ss').parse(date);
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

DateTime? getDateAndTime2(String? date) {
  try {
    if (date != null) {
      return DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

DateTime? getDateAndTime3(String? date) {
  try {
    if (date != null) {
      return DateFormat('yyyy-MM-ddTHH:mm:ss').parse(date);
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

DateTime? getDate(String? date) {
  try {
    if (date != null) {
      return DateFormat('yyyy-MM-dd').parse(date);
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
