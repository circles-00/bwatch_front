class Movie {
  final int id;
  final String title;
  final String overview;
  final String image;
  final String rating;

  Movie(
      {required this.id,
      required this.title,
      required this.overview,
      required this.image,
      required this.rating});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return new Movie(
        id: json['id'],
        title: json['title'],
        overview: json['overview'],
        image: json['poster_path'],
        rating: json['vote_average']);
  }

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'image': image,
      'rating': rating
    };
  }
}
