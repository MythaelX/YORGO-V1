class Sport {
  int id;
  String name;
  String? description;
  int category;
  String? icon;

  Sport({
    required this.id,
    required this.name,
    required this.category,
    this.description,
    this.icon,
  });

  Sport.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description']!,
        icon = json['icon']!,
        category = json['category'];
}
