class Movie {
  final int id;
  final String title;
  final String overview;
  final String image;

  Movie(
      {required this.id,
      required this.title,
      required this.overview,
      required this.image});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return new Movie(
        id: json['id'],
        title: json['title'],
        overview: json['overview'],
        image: json['poster_path']);
  }

  Map toJson() {
    return {'id': id, 'title': title, 'overview': overview, 'image': image};
  }
}
