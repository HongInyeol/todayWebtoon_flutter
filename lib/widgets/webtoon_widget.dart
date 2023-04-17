import 'package:app/screen/detail_screen.dart';
import 'package:flutter/material.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon(
      {super.key, required this.title, required this.thumb, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //navigator.push를 사용하면 에니메이션 효과를 통해 유저가 다른 페이지로 왔다는것을 인식시킬 수 있다.
        Navigator.push(
          context,
          MaterialPageRoute(
            //모든 에니메이션을 생성하는 라우터
            builder: (context) => DetailScreen(
              id: id,
              title: title,
              thumb: thumb,
            ),
            fullscreenDialog: true, //다이얼로그 형식으로 페이지를 띄운다. 밑에서 위로.
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            // 두 화면사이에 에니메이션을 보여주는 위젯, tag는 두 화면에서 같은 값을 가지고 있어야 한다.
            tag: id,
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(10, 10),
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
              child: Image.network(
                thumb,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
