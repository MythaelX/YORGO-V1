class Category {
  int id;
  String name;
  String? description;
  String? icon;

  Category({required this.id, required this.name, this.description, this.icon});

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description']!,
        icon = json['icon']!;
}
