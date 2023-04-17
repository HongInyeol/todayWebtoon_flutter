class WebtoonEpisodeModel {
  final String title, thumb, id, rating, date;

  WebtoonEpisodeModel.fromJson(
    Map<String, dynamic> json,
  )   : title = json['title'],
        thumb = json['thumb'],
        id = json['id'],
        rating = json['rating'],
        date = json['date'];
}
