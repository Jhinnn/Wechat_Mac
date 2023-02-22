import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:random_string/random_string.dart';
import 'package:username/username.dart';
import 'package:wechat/hive/conversation_adapter.dart';
import 'package:wechat/hive/hive_tool.dart';

const ValueKey valueKey = ValueKey(1);

class WechatMessageWidget extends StatefulWidget {
  final DBUtil? dbUtil;
  final String conversationId;
  const WechatMessageWidget(
      {Key? key, required this.dbUtil, required this.conversationId})
      : super(key: key);

  @override
  State<WechatMessageWidget> createState() => _WechatMessageWidgetState();
}

class _WechatMessageWidgetState extends State<WechatMessageWidget> {
  List<Conversation> newMessageList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dbUtil != null) {
      return ValueListenableBuilder(
          valueListenable: widget.dbUtil!.conversationBox.listenable(),
          builder: (context, value, child) {
            if (value.isEmpty || widget.conversationId.isEmpty) {
              return Container();
            } else {
              List<ConversationModel> result =
                  value.values.toList().cast<ConversationModel>();
              List<ConversationModel> conversationModelList = result
                  .where((element) =>
                      element.conversationId == widget.conversationId)
                  .toList();
              if (conversationModelList.isEmpty) {
                return Container();
              } else {
                List<Conversation> converstaionList = conversationModelList
                    .first.converstaionList
                    .cast<Conversation>();
                converstaionList = converstaionList.reversed.toList();
                // return CustomScrollView(
                //   controller: ScrollController(),
                //   reverse: true,
                //   center: valueKey,
                //   slivers: [
                //     //我们的列表是 reverse 的，所以需要将新数据的 SliverList 放在 centerKey 的上面，把旧数据的 SliverList放在 centerKey 下面
                //     SliverList(
                //       delegate: SliverChildBuilderDelegate(
                //         (BuildContext context, int index) {
                //           return newMessageList[index].isSelf
                //               ? selfChat(newMessageList[index])
                //               : otherChat(newMessageList[index]);
                //         },
                //         childCount: newMessageList.length,
                //       ),
                //     ),
                //     const SliverPadding(
                //       padding: EdgeInsets.only(top: 120),
                //       key: valueKey,
                //     ),
                //     SliverList(
                //       delegate: SliverChildBuilderDelegate(
                //         (BuildContext context, int index) {
                //           // var item = loadMoreData[index];
                //           return converstaionList[index].isSelf
                //               ? selfChat(converstaionList[index])
                //               : otherChat(converstaionList[index]);
                //         },
                //         childCount: converstaionList.length,
                //       ),
                //     ),
                //   ],
                // );
                return result.isEmpty
                    ? Container()
                    : ListView.builder(
                        reverse: true,
                        padding:
                            const EdgeInsets.only(left: 20, top: 10, right: 20),
                        itemBuilder: (_, index) {
                          return converstaionList[index].isSelf
                              ? selfChat(converstaionList[index])
                              : otherChat(converstaionList[index]);
                        },
                        itemCount: converstaionList.length);
              }
            }
          });
    } else {
      return Container();
    }

    // return FutureBuilder(
    //     future:
    //         DefaultAssetBundle.of(context).loadString('assets/json/conversation.json'),
    //     builder: (context, snapshot) {
    //       if (snapshot.data = null) {
    //         ConversationModel conversationListModel =
    //             ConversationModel.fromJson(
    //                 json.decode(snapshot.data.toString()));
    //         return ListView.builder(
    //           padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
    //           itemBuilder: (_, index) {
    //             Conversation conversation =
    //                 conversationListModel.conversation[index];
    //             return conversation.isSelf
    //                 ? selfChat(conversation)
    //                 : otherChat(conversation);
    //           },
    //           itemCount: conversationListModel.conversation.length,
    //         );
    //       } else {
    //         return Container();
    //       }
    //     });
  }

  // getNewConverstaionList() {
  //   for (var i = 0; i < randomBetween(2, 5); i++) {
  //     Conversation conversation = Conversation(
  //         conversationId: widget.conversationId,
  //         messageId: randomAlphaNumeric(15),
  //         userID: randomAlphaNumeric(20),
  //         userName: Username.cn().fullname,
  //         userIcon:
  //             "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fblog%2F202103%2F23%2F20210323132934_d2473.thumb.1000_0.png&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1678416650&t=3fa34a17cfe6aa35381f56df9b6beb4e",
  //         content: randomAlphaNumeric(20) + "$i",
  //         conversationType: 1,
  //         isSelf: false,
  //         time: DateTime.now().toString());

  //     newMessageList.add(conversation);
  //   }
  // }

  Widget otherChat(Conversation conversation) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            // getNewConverstaionList();
            // setState(() {});
          },
          child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedNetworkImage(
                imageUrl: conversation.userIcon,
                width: 32,
                height: 32,
              )),
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(conversation.userName,
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
                    conversation.content,
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
            Text(conversation.userName,
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
                    conversation.content,
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
              imageUrl: conversation.userIcon,
              width: 32,
              height: 32,
            )),
      ],
    );
  }
}
