import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_string/random_string.dart';
import 'package:username/username.dart';
import 'package:wechat/hive/conversation_list_adapter.dart';
import 'package:wechat/hive/hive_tool.dart';
import 'package:wechat/page/conversation/wechat_message_widget.dart';
import 'package:wechat/page/wechat_home_page.dart';

import '../../hive/conversation_adapter.dart';

class WechatConversataionListPage extends ConsumerWidget {
  WechatConversataionListPage({
    super.key,
    this.dbUtil,
  });
  final DBUtil? dbUtil;

  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ConversationListModel? conversationListModel =
        ref.watch(conversationModelProvider);
    if (conversationListModel == null) {
      return const Center(
        child: FlutterLogo(size: 100),
      );
    } else {
      return Container(
        color: const Color.fromRGBO(243, 243, 243, 1),
        child: Column(
          children: [
            Container(
              height: 60,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(conversationListModel.userName,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 16)),
                  const Icon(
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
                conversationId: conversationListModel.conversationId,
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
                                  conversationId:
                                      conversationListModel.conversationId,
                                  messageId: randomAlphaNumeric(15),
                                  userID: conversationListModel.userID,
                                  userName: conversationListModel.userName,
                                  userIcon: conversationListModel.userIcon,
                                  content: randomAlphaNumeric(20),
                                  conversationType: 1,
                                  isSelf: randomBetween(0, 1) == 0,
                                  time: DateTime.now().toString());

                              List<dynamic>? conversationList = dbUtil!
                                  .conversationBox
                                  .get(conversationListModel.conversationId);
                              if (conversationList != null) {
                                conversationList.add(conversation);
                                dbUtil!.conversationBox.put(
                                    conversationListModel.conversationId,
                                    conversationList);
                              } else {
                                dbUtil!.conversationBox.put(
                                    conversationListModel.conversationId,
                                    [conversation]);
                              }
                            },
                            child: Image.asset(
                                'assets/images/shipintonghua.png',
                                width: 18),
                          ),
                        ]),
                  ),
                  Expanded(
                      child: RawKeyboardListener(
                          focusNode: FocusNode(),
                          onKey: (RawKeyEvent value) {
                            if (value is RawKeyUpEvent) {
                              if (value.logicalKey.keyLabel == 'Enter' &&
                                  !value.isShiftPressed) {
                                final val = _textEditingController.value;

                                final messageWithoutNewLine =
                                    _textEditingController.text.substring(
                                            0, val.selection.start - 1) +
                                        _textEditingController.text
                                            .substring(val.selection.start);
                                _textEditingController.value = TextEditingValue(
                                  text: messageWithoutNewLine,
                                  selection: TextSelection.fromPosition(
                                    TextPosition(
                                        offset: messageWithoutNewLine.length),
                                  ),
                                );

                                _sendMessage(_textEditingController.text,
                                    conversationListModel);
                              }
                            }
                          },
                          child: TextField(
                            cursorWidth: 0.8,
                            cursorHeight: 15,
                            cursorColor: Colors.black,
                            controller: _textEditingController,
                            maxLines: 10,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black, height: 1.3),
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ))),
                ],
              ),
            )
          ],
        ),
      );
    }
  }

  void _sendMessage(String text, ConversationListModel conversationListModel) {
    if (text.isEmpty) {
      return;
    } else {
      _textEditingController.clear();
      Conversation conversation = Conversation(
          conversationId: conversationListModel.conversationId,
          messageId: randomAlphaNumeric(15),
          userID: conversationListModel.userID,
          userName: conversationListModel.userName,
          userIcon: conversationListModel.userIcon,
          content: text,
          conversationType: 1,
          isSelf: true,
          time: DateTime.now().toString());

      List<dynamic>? conversationList =
          dbUtil!.conversationBox.get(conversationListModel.conversationId);
      if (conversationList != null) {
        conversationList.add(conversation);
        dbUtil!.conversationBox
            .put(conversationListModel.conversationId, conversationList);
      } else {
        dbUtil!.conversationBox
            .put(conversationListModel.conversationId, [conversation]);
      }
    }
  }
}
