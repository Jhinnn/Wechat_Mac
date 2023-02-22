import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_string/random_string.dart';
import 'package:username/username.dart';
import 'package:wechat/hive/hive_tool.dart';
import 'package:wechat/page/conversation/wechat_message_widget.dart';
import 'package:wechat/page/wechat_home_page.dart';

import '../../hive/conversation_adapter.dart';

final List<String> imgList = [
  "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fblog%2F202103%2F23%2F20210323132934_d2473.thumb.1000_0.png&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1678416650&t=3fa34a17cfe6aa35381f56df9b6beb4e",
  "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fblog%2F202107%2F12%2F20210712160723_84b09.thumb.1000_0.jpg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1678414223&t=bc725cf183137f0cda68edf40c47bc2c",
  "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fitem%2F201706%2F30%2F20170630004557_GLmWV.jpeg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1678416650&t=832065c437fd74931330b16289edbc8ag",
  "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fblog%2F202106%2F13%2F20210613110106_f0776.thumb.1000_0.jpeg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1678416650&t=7769d0745da4f0154390c8e15792a9ca",
];

class WechatConversataionListPage extends ConsumerWidget {
  const WechatConversataionListPage({
    super.key,
    this.dbUtil,
  });
  final DBUtil? dbUtil;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String conversationId = ref.watch(conversationIdIndex);

    return Container(
      color: const Color.fromRGBO(243, 243, 243, 1),
      child: Column(
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('一棵树',
                    style: TextStyle(color: Colors.black, fontSize: 16)),
                Icon(
                  Icons.more_horiz,
                  size: 25,
                  color: Colors.black,
                )
              ],
            ),
          ),
          const Divider(
            color: Color.fromRGBO(228, 223, 222, 1),
            thickness: 0,
            height: 1,
          ),
          Expanded(
              child: Container(
            color: const Color.fromRGBO(243, 243, 243, 1),
            child: WechatMessageWidget(
              dbUtil: dbUtil,
              conversationId: conversationId,
            ),
          )),
          const Divider(
            color: Color.fromRGBO(228, 223, 222, 1),
            height: 1,
            thickness: 0,
          ),
          Container(
            height: 156,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Container(
                  height: 48,
                  padding: const EdgeInsets.only(top: 14),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/images/biaoqing.png',
                                width: 28),
                            const SizedBox(width: 16),
                            Image.asset('assets/images/wenjianjia_o.png',
                                width: 28),
                            const SizedBox(width: 18),
                            Row(
                              children: [
                                Image.asset('assets/images/jianqie.png',
                                    width: 20),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xff2c2c2c),
                                  size: 12,
                                )
                              ],
                            ),
                            const SizedBox(width: 16),
                            InkWell(
                                onTap: () {
                                  dbUtil!.conversationBox.clear();
                                },
                                child: Image.asset('assets/images/xiaoxi.png',
                                    width: 23)),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            ///添加聊天消息
                            Conversation conversation = Conversation(
                                conversationId: conversationId,
                                messageId: randomAlphaNumeric(15),
                                userID: randomAlphaNumeric(20),
                                userName: Username.cn().fullname,
                                userIcon:
                                    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fblog%2F202103%2F23%2F20210323132934_d2473.thumb.1000_0.png&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1678416650&t=3fa34a17cfe6aa35381f56df9b6beb4e",
                                content: randomAlphaNumeric(20),
                                conversationType: 1,
                                isSelf: randomBetween(0, 1) == 0,
                                time: DateTime.now().toString());

                            List<dynamic> result =
                                dbUtil!.conversationBox.values.toList();
                            if (result.isEmpty) {
                              dbUtil!.conversationBox.add(ConversationModel(
                                  conversationId: conversationId,
                                  converstaionList: [conversation]));
                            } else {
                              for (ConversationModel element in result) {
                                if (element.conversationId == conversationId) {
                                  element.converstaionList.add(conversation);
                                  dbUtil!.conversationBox.add(element);
                                  break;
                                } else {
                                  dbUtil!.conversationBox.add(ConversationModel(
                                      conversationId: conversationId,
                                      converstaionList: [conversation]));
                                }
                              }
                            }
                          },
                          child: Image.asset('assets/images/shipintonghua.png',
                              width: 18),
                        ),
                      ]),
                ),
                const Expanded(
                    child: TextField(
                  cursorWidth: 0.8,
                  cursorHeight: 15,
                  cursorColor: Colors.black,
                  maxLines: 10,
                  style:
                      TextStyle(fontSize: 14, color: Colors.black, height: 1.3),
                  decoration: InputDecoration(border: InputBorder.none),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
