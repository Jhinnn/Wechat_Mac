import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:random_string/random_string.dart';
import 'package:username/username.dart';
import 'package:wechat/hive/conversation_list_adapter.dart';
import 'package:wechat/hive/hive_tool.dart';
import 'package:wechat/page/conversation/wechat_conversation_page.dart';
import 'package:wechat/page/conversation/wechat_conversation_widget.dart';

class WechatConversataionListPage extends ConsumerWidget {
  const WechatConversataionListPage({
    super.key,
    this.dbUtil,
  });
  final DBUtil? dbUtil;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Container(
            width: 250,
            color: const Color.fromRGBO(247, 247, 247, 1),
            child: Column(children: [
              Container(
                height: 60,
                color: const Color.fromRGBO(247, 247, 247, 1),
                margin: const EdgeInsets.only(left: 13),
                child: Row(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 26,
                        maxWidth: 190,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 12),
                          hintText: '搜索',
                          hintStyle: const TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: const Color.fromRGBO(233, 233, 233, 1),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        ConversationListModel conversationListModel =
                            ConversationListModel(
                                conversationId: randomAlphaNumeric(15),
                                userID: randomAlphaNumeric(20),
                                userName: Username.cn().fullname,
                                userIcon:
                                    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fblog%2F202103%2F23%2F20210323132934_d2473.thumb.1000_0.png&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1678416650&t=3fa34a17cfe6aa35381f56df9b6beb4e",
                                content: randomAlphaNumeric(20),
                                conversationType: 1,
                                isMute: 0,
                                time: DateTime.now().toString());

                        dbUtil!.conversationListBox.add(conversationListModel);
                      },
                      child: Container(
                          width: 26,
                          height: 26,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(233, 233, 233, 1),
                              borderRadius: BorderRadius.circular(4)),
                          child: const Icon(Icons.add_outlined,
                              size: 18, color: Colors.grey)),
                    )
                  ],
                ),
              ),
              Expanded(
                child: dbUtil != null
                    ? ValueListenableBuilder(
                        valueListenable:
                            dbUtil!.conversationListBox.listenable(),
                        builder: (context, value, child) {
                          List<ConversationListModel> result = value.values
                              .toList()
                              .cast<ConversationListModel>();
                          return WechatConversataionWidget(
                            result: result,
                            onTap: (index) {
                              dbUtil!.conversationListBox.deleteAt(index);
                            },
                          );
                        })
                    : Container(),
              )
            ])),
        const VerticalDivider(
          color: Color.fromRGBO(228, 223, 222, 1),
          thickness: 0,
          width: 1,
        ),
        Expanded(child: _conversationWidget())
      ],
    );
  }

  _conversationWidget() {
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
            child: const ConversationWidget(),
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
                            Image.asset('assets/images/xiaoxi.png', width: 23),
                          ],
                        ),
                        Image.asset('assets/images/shipintonghua.png',
                            width: 18),
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


