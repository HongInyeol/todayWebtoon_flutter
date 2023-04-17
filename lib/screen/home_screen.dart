import 'package:app/models/webtoon_model.dart';
import 'package:app/services/api_service.dart';
import 'package:app/widgets/webtoon_widget.dart';
import 'package:flutter/material.dart';

//const는 compile time에 결정되는 상수. runtime에 결정되는 final과 다름. 실행정에 값을 알아야 const.
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  Future<List<WebtoonModel>> webtoons = ApiService
      .getTodaysToons(); //getTodaysToons는 필요한 argument가 없어서 이렇게 사용이 가능함.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 2,
        title: const Text(
          'Today\'s 툰',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          //snapshot은 Future의 결과를 담고있음. error, data.
          if (snapshot.hasData) {
            print('snapshot data is success');
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot)),
              ],
            );
          }
          print('snapshot error is ${snapshot.error}');
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  //ListView.separated는 ListView.builder와 비슷한데, separatorBuilder를 통해 각 아이템 사이에 separator를 넣을 수 있음.
  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      itemBuilder: (context, index) {
        final webtoon = snapshot.data![index];

        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 40,
        );
      },
    );
  }
}
