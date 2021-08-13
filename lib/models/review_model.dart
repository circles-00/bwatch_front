class Review {
  final String author;
  final String content;
  final String image;
  final String rating;

  Review({
    required this.author,
    required this.content,
    required this.image,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return new Review(
      author: json['username'],
      content: json['content'],
      image: json['avatar_path'],
      rating: json['rating'],
    );
  }

  Map toJson() {
    return {
      'author': author,
      'content': content,
      'image': image,
      'rating': rating,
    };
  }
}
