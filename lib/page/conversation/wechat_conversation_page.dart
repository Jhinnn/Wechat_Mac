import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat/models/conversation_model.dart';

class ConversationWidget extends StatefulWidget {
  const ConversationWidget({Key? key}) : super(key: key);

  @override
  State<ConversationWidget> createState() => _ConversationWidgetState();
}

class _ConversationWidgetState extends State<ConversationWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            DefaultAssetBundle.of(context).loadString('assets/json/conversation.json'),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            ConversationModel conversationListModel =
                ConversationModel.fromJson(
                    json.decode(snapshot.data.toString()));
            return ListView.builder(
              padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
              itemBuilder: (_, index) {
                Conversation conversation =
                    conversationListModel.conversation![index];
                return conversation.isSelf!
                    ? selfChat(conversation)
                    : otherChat(conversation);
              },
              itemCount: conversationListModel.conversation!.length,
            );
          } else {
            return Container();
          }
        });
  }

  Widget otherChat(Conversation conversation) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CachedNetworkImage(
              imageUrl: conversation.icon!,
              width: 32,
              height: 32,
            )),
        const SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(conversation.userName!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[500], fontSize: 12)),
            const SizedBox(
              height: 3,
            ),
            Bubble(
              padding: const BubbleEdges.all(9),
              margin: const BubbleEdges.only(bottom: 10),
              alignment: Alignment.centerLeft,
              elevation: 0,
              nipOffset: 8,
              nip: BubbleNip.leftTop,
              nipHeight: 8,
              nipWidth: 8,
              color: Colors.white,
              child: Container(
                  constraints: BoxConstraints.loose(const Size(280, 1000)),
                  child: Text(
                    conversation.content!,
                    maxLines: 10,
                    style: const TextStyle(height: 1.3, fontSize: 13.5),
                  )),
            ),
          ],
        )
      ],
    );
  }

  Widget selfChat(Conversation conversation) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(conversation.userName!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.grey[500], fontSize: 12)),
            const SizedBox(
              height: 3,
            ),
            Bubble(
              padding: const BubbleEdges.all(9),
              margin: const BubbleEdges.only(bottom: 10),
              alignment: Alignment.centerRight,
              elevation: 0,
              nipOffset: 8,
              nip: BubbleNip.rightTop,
              nipHeight: 8,
              nipWidth: 8,
              color: const Color.fromRGBO(178, 235, 114, 1),
              child: Container(
                  constraints: BoxConstraints.loose(const Size(280, 1000)),
                  child: Text(
                    conversation.content!,
                    maxLines: 10,
                    style: const TextStyle(height: 1.3, fontSize: 13.5),
                  )),
            ),
          ],
        ),
        const SizedBox(
          width: 8,
        ),
        ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CachedNetworkImage(
              imageUrl: conversation.icon!,
              width: 32,
              height: 32,
            )),
      ],
    );
  }
}
