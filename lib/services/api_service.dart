//normal dart class

import 'dart:convert';

import 'package:app/models/webtoon_detail.dart';
import 'package:app/models/webtoon_episode.dart';
import 'package:app/models/webtoon_model.dart';
import 'package:http/http.dart' as http; //이름지정

class ApiService {
  static const basesUrl = 'https://webtoon-crawler.nomadcoders.workers.dev';
  static const String today = 'today';

//static keyword는 class level로 사용가능. class instance를 생성하지 않고도 사용가능. class.method()로 사용가능.
  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$basesUrl/$today');
    final response =
        await http.get(url); //async fn 내에서만 사용가능. 보통 Future 타입과 사용.

    if (response.statusCode == 200) {
      //jsonDecode는 dynamic 타입을 반환함.
      final webToons = jsonDecode(
        response.body,
      );

      //json데이터를 dart class로 변환
      for (var webtoon in webToons) {
        final instance = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(instance);
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$basesUrl/$id');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }

    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    final url = Uri.parse('$basesUrl/$id/episodes');
    final response = await http.get(url);

    List<WebtoonEpisodeModel> latestList = [];
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        latestList.add(WebtoonEpisodeModel.fromJson(episode));
      }

      return latestList;
    }
    throw Error();
  }
}
