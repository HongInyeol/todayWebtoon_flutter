class WebtoonDetailModel {
  final String title, about, thumb, genre, age;

  WebtoonDetailModel.fromJson(
    Map<String, dynamic> json,
  )   : title = json['title'],
        about = json['about'],
        thumb = json['thumb'],
        genre = json['genre'],
        age = json['age'];
}
