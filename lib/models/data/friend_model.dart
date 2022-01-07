class Friend {
  int id;
  String username;
  String? profile_image;
  String? address_text;

  Friend(
      {required this.id,
      required this.username,
      this.profile_image,
      this.address_text});

  static String? getImageUser(String? image) {
    if (image != null &&
        image != "media/default_profile_image.png" &&
        image != "") {
      return "http://yorgoapi.herokuapp.com/media/" + image;
    } else {
      return null;
    }
  }

  Friend.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        profile_image = getImageUser(json['profile_image']),
        address_text = json['address_text'];
}
