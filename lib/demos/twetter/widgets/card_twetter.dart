import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crise/components/avatar.component.dart';
import 'package:flutter_crise/components/text.component.dart';
import 'package:flutter_crise/components/carrousel-image.component.dart';

class CardTwetter extends StatefulWidget {
  String photo;
  String name;
  String nickName;
  String description;
  int likes;
  List<String> comments;
  List<dynamic> images;
  Function onLike;
  CardTwetter(
      {super.key,
      required this.photo,
      required this.name,
      required this.nickName,
      required this.description,
      required this.likes,
      required this.comments,
      required this.images,
      required this.onLike});

  @override
  State<CardTwetter> createState() => _CardTwetterState();
}

class _CardTwetterState extends State<CardTwetter> {
  bool showMoreText = false;
  bool likeCurrentUser = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            likeCurrentUser
                ? Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.heart_fill,
                            color: Color.fromARGB(255, 240, 19, 93)),
                        const SizedBox(width: 5),
                        TextComponent(
                            value: 'Curtido por você',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700]),
                      ],
                    ))
                : Container(),
            const SizedBox(height: 2),
            Row(
              children: [
                AvatarComponent(radius: 25, imageUrl: widget.photo),
                const SizedBox(width: 5),
                TextComponent(
                    value: widget.name,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
                const SizedBox(width: 5),
                TextComponent(
                    value: widget.nickName,
                    color: Colors.grey[500],
                    fontSize: 18)
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(left: 50),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        showMoreText = !showMoreText;
                      });
                    },
                    child: Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                        child: showMoreText == false
                            ? Row(
                                children: [
                                  SizedBox(
                                    width: 340,
                                    child: RichText(
                                      text: TextSpan(
                                        children: _buildTextSpans(widget
                                                    .description.length >
                                                150
                                            ? '${widget.description.substring(0, 150)}...'
                                            : widget.description),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[
                                                900]), // Cor padrão para o restante do texto
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  SizedBox(
                                    width: 340,
                                    child: RichText(
                                      text: TextSpan(
                                        children:
                                            _buildTextSpans(widget.description),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[
                                                900]), // Cor padrão para o restante do texto
                                      ),
                                    ),
                                  ),
                                ],
                              )))),
            Padding(
                padding: const EdgeInsets.only(left: 55, top: 2),
                child: CarrouselImageComponent(
                    imageUrls: widget.images, onPageLongClick: (index) {})),
            Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(CupertinoIcons.chat_bubble,
                                color: Colors.grey[500])),
                        TextComponent(
                            value: widget.comments.length.toString(),
                            color: Colors.grey[500]),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              widget.onLike();
                              setState(() {
                                likeCurrentUser = !likeCurrentUser;
                              });
                            },
                            icon: likeCurrentUser == false
                                ? Icon(CupertinoIcons.suit_heart,
                                    color: Colors.grey[500])
                                : Icon(CupertinoIcons.heart_fill,
                                    color: Color.fromARGB(255, 240, 19, 93))),
                        TextComponent(
                            value: widget.likes.toString(),
                            color: Colors.grey[500]),
                      ],
                    )
                  ],
                )),
          ],
        ));
  }

  List<TextSpan> _buildTextSpans(String text) {
    final RegExp hashtagExp = RegExp(r'#\w+');
    final List<TextSpan> spans = [];
    int start = 0;

    hashtagExp.allMatches(text).forEach((match) {
      if (match.start != start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }

      spans.add(
        TextSpan(
          text: match.group(0),
          style: const TextStyle(color: Color.fromARGB(255, 255, 102, 0)),
        ),
      );

      start = match.end;
    });

    // Adiciona o restante do texto (caso não termine com uma hashtag)
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }

    return spans;
  }
}
