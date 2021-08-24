class User {
  final String id;
  final String firstName;
  final String lastName;
  final String avatar;
  final List<int> favoriteIDs;
  final List<int> watchListIDs;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.avatar,
      required this.favoriteIDs,
      required this.watchListIDs});

  factory User.fromJson(Map<String, dynamic> json) {
    return new User(
        id: json['_id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        avatar: json['avatar'],
        favoriteIDs: json['favMovies'].cast<int>(),
        watchListIDs: json['watchList'].cast<int>());
  }

  Map toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'avatar': avatar,
      'favoriteIDs': favoriteIDs,
      'watchListIDs': watchListIDs
    };
  }
}
