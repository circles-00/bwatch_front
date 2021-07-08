class Actor {
  final int id;
  final String name;
  final String image;

  Actor({required this.id, required this.name, required this.image});

  factory Actor.fromJson(Map<String, dynamic> json) {
    return new Actor(
        id: json['id'], name: json['name'], image: json['profile_path']);
  }

  Map toJson() {
    return {'id': id, 'name': name, 'image': image};
  }
}
