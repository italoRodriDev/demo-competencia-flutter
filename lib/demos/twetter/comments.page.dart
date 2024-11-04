import 'package:app_portifolio/demos/twetter/widgets/card_twetter.dart';
import 'package:app_portifolio/demos/twetter/widgets/card_twetter_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crise/components/avatar.component.dart';
import 'package:flutter_crise/components/text.component.dart';
import 'package:flutter_crise/components/button.component.dart';

class CommentsTwetter extends StatefulWidget {
  dynamic twetter;
  CommentsTwetter({super.key, required this.twetter});

  @override
  State<CommentsTwetter> createState() => _CommentsTwetterState();
}

class _CommentsTwetterState extends State<CommentsTwetter> {
  List<dynamic> data = [
    {
      "photo":
          "https://www.tenda.com/blog/wp-content/uploads/2021/09/Pessoa-fisica-mobile.jpg",
      "name": "Maria Silva",
      "nickName": "maria_silva",
      "likes": 10,
      "comment": "Achei super legal",
    },
    {
      "photo":
          "https://cdn.pixabay.com/photo/2016/03/31/19/56/avatar-1295395_640.png",
      "name": "Carlos Souza",
      "nickName": "carlos_souza",
      "likes": 25,
      "comment": "Melhor que essa só outra",
    },
    {
      "photo":
          "https://static.wikia.nocookie.net/xbox/images/1/15/19_-_YIswnk0.png/revision/latest/scale-to-width-down/250?cb=20210628044527",
      "name": "Ana Paula",
      "nickName": "ana_paula123",
      "likes": 8,
      "comment": "Ancioso pela próxima"
    },
    {
      "photo":
          "https://static1.squarespace.com/static/56dc8dcca3360c8bedccf836/57d5d447363d3cfcab824775/57d5d47c363d3cfcab8257d7/1473631356697/bear.jpg?format=original",
      "name": "Pedro Lima",
      "nickName": "pedro_lima",
      "likes": 14,
      "comment": "Já quero outra",
    },
    {
      "photo":
          "https://static1.squarespace.com/static/56dc8dcca3360c8bedccf836/57d5d447363d3cfcab824775/57d5d47b363d3cfcab8257a5/1473631355618/Monster-04.jpg?format=original",
      "name": "Beatriz Gonçalves",
      "nickName": "bia_goncalves",
      "likes": 20,
      "comment": "Maravilhoso!"
    },
    {
      "photo":
          "https://mga-prod.s3.amazonaws.com/public/img/users/cIGCQcX7oCej0HIfMQDTBNb7mhsI0hKeJDsgZPsv.jpg",
      "name": "Italo R. Santos",
      "nickName": "italo_rd25",
      "likes": 16,
      "comment": "Obrigado pessoal",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 102, 0),
        foregroundColor: Colors.white,
        elevation: 0.8,
        actions: [
          Padding(
              padding: EdgeInsets.all(2),
              child: Row(
                children: [
                  TextComponent(
                      value: '@italo_rd25',
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                  const SizedBox(width: 5),
                  const AvatarComponent(
                      radius: 25,
                      imageUrl:
                          'https://mga-prod.s3.amazonaws.com/public/img/users/cIGCQcX7oCej0HIfMQDTBNb7mhsI0hKeJDsgZPsv.jpg')
                ],
              ))
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  TextComponent(
                    value: "Comentários",
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              )),
          const Divider(),
          CardTwetter(
              photo: widget.twetter['photo'],
              name: widget.twetter['name'],
              nickName: widget.twetter['nickName'],
              description: widget.twetter['description'],
              likes: widget.twetter['likes'],
              enableClickComment: false,
              enableClickLike: false,
              comments: [],
              images: [],
              onLike: () {},
              onPressedComments: () {}),
          for (var i in data)
            CardCommentTwetter(
                photo: i['photo'],
                name: i['name'],
                nickName: i['nickName'],
                likes: i['likes'],
                comment: i['comment'])
        ],
      ))),
    );
  }
}
