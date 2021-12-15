class Sport {
  String name;
  String? description;
  int category;
  String? icon;

  Sport(
      {required this.name,
      required this.category,
      this.description,
      this.icon});

  Sport.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description']!,
        icon = json['icon']!,
        category = json['category'];
}
