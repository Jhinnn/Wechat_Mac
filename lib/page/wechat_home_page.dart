import 'dart:convert';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/hive/contacts_adapter.dart';
import 'package:wechat/page/collect/collect_detail_page.dart';
import 'package:wechat/page/collect/collect_page.dart';
import 'package:wechat/page/contacts/contacts_detail_page.dart';
import 'package:wechat/page/conversation/wechat_conversation_list_page.dart';
import 'package:wechat/page/conversation/wechat_conversation_page.dart';
import 'package:wechat/hive/hive_tool.dart';
import 'package:flutter_svg/svg.dart';

import 'contacts/contacts_page.dart';

final conversationSelectedIndex = StateProvider<int>((ref) => 1);
final tabbarSelectedIndex = StateProvider<int>((ref) => 1);

final pageIndexProvider = StateProvider<int>((ref) => 0);

class WechatHomePage extends StatefulWidget {
  const WechatHomePage({Key? key}) : super(key: key);

  @override
  State<WechatHomePage> createState() => _WechatHomePageState();
}

class _WechatHomePageState extends State<WechatHomePage> {
  DBUtil? dbUtil;

  List<String> collectList = ['全部收藏', '图片与视频', '链接', '笔记', '文件', '语音', '聊天记录'];
  @override
  void initState() {
    init();

    super.initState();
  }

  Future<void> init() async {
    dbUtil = await DBUtil.getInstance();
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        const WechatTabbar(),
        Consumer(builder: (context, ref, child) {
          return Expanded(
            child: IndexedStack(
              index: ref.watch(tabbarSelectedIndex) - 1,
              children: [
                WechatConversataionListPage(dbUtil: dbUtil),
                ContactsPage(
                  dbUtil: dbUtil,
                ),
                const CollectPage(),
              ],
            ),
          );
        }),
       
       
      ]),
    );
  }

/*
  _conversatonListWidget() {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context)
          .loadString('json/conversation_list.json'),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          ConversationListModel conversationListModel =
              ConversationListModel.fromJson(
                  json.decode(snapshot.data.toString()));
          return Container(
            width: 250,
            color: const Color.fromRGBO(247, 247, 247, 1),
            child: Column(
              children: [
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
                          // ConversationListModel conversationListModel =
                          //     ConversationListModel(
                          //         conversationId: randomAlphaNumeric(15),
                          //         userID: randomAlphaNumeric(20),
                          //         userName: randomAlphaNumeric(4),
                          //         userIcon: "",
                          //         content: randomAlphaNumeric(20),
                          //         conversationType: 1,
                          //         isMute: 0,
                          //         time: "18:29");

                          // dbUtil!.conversationListBox
                          //     .add(conversationListModel);
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
                    child: ListView.builder(
                        itemCount:
                            conversationListModel.conversationList!.length,
                        itemBuilder: (_, index) {
                          ConversationList conversationList =
                              conversationListModel.conversationList![index];
                          return Container(
                            margin: const EdgeInsets.only(
                              left: 12,
                              right: 8,
                            ),
                            height: 68,
                            child: Row(
                              children: [
                                conversationList.type == "0"
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: CachedNetworkImage(
                                          imageUrl: conversationList.icon!,
                                          width: 35,
                                          height: 35,
                                        ))
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: CachedNetworkImage(
                                          imageUrl: conversationList
                                              .numbers!.first.icon!,
                                          width: 35,
                                          height: 35,
                                        )),
                                const SizedBox(width: 10),
                                SizedBox(
                                  height: 44,
                                  width: 182,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(conversationList.userName!,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14)),
                                          Text(conversationList.time!,
                                              style: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: 10.5))
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Text(conversationList.content!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 12))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }))
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
  */

  
}

class WechatTabbar extends ConsumerWidget {
  const WechatTabbar({super.key});

  @override
  Widget build(Object context, WidgetRef ref) {
    int index = ref.watch(tabbarSelectedIndex);
    return Container(
      width: 64,
      color: const Color.fromRGBO(228, 223, 222, 1),
      child: Padding(
        padding: const EdgeInsets.only(top: 66, bottom: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset('assets/images/avatars.png', width: 37),
                ),
                const SizedBox(height: 28),
                InkWell(
                  onTap: () {
                    ref
                        .read(pageIndexProvider.notifier)
                        .update((state) => state = 0);
                    ref
                        .read(tabbarSelectedIndex.notifier)
                        .update((state) => state = 1);
                  },
                  child: SvgPicture.asset(
                    index == 1
                        ? 'assets/images/TabBar_Chat_Selected.svg'
                        : 'assets/images/TabBar_Chat.svg',
                    width: 30,
                    height: 30,
                    color: index == 1
                        ? const Color.fromARGB(255, 78, 210, 66)
                        : Colors.black54,
                  ),
                ),
                const SizedBox(height: 18),
                InkWell(
                    onTap: () {
                      ref
                          .read(tabbarSelectedIndex.notifier)
                          .update((state) => state = 2);

                      ref
                          .read(pageIndexProvider.notifier)
                          .update((state) => state = 1);
                    },
                    child: SvgPicture.asset(
                      index == 2
                          ? 'assets/images/TabBar_Contacts_Selected.svg'
                          : 'assets/images/TabBar_Contacts.svg',
                      width: 30,
                      height: 30,
                      color: index == 2
                          ? const Color.fromARGB(255, 78, 210, 66)
                          : Colors.black54,
                    )),
                const SizedBox(height: 18),
                InkWell(
                    onTap: () {
                      ref
                        .read(tabbarSelectedIndex.notifier)
                          .update((state) => state = 3);

                      ref
                          .read(pageIndexProvider.notifier)
                          .update((state) => state = 2);
                    },
                    child: SvgPicture.asset(
                      index == 3
                          ? 'assets/images/TabBar_Favorites_Selected.svg'
                          : 'assets/images/TabBar_Favorites.svg',
                      width: 30,
                      height: 30,
                      color: index == 3
                          ? const Color.fromARGB(255, 78, 210, 66)
                          : Colors.black54,
                    )),
                const SizedBox(height: 18),
                InkWell(
                  onTap: () async {
                    final window =
                        await DesktopMultiWindow.createWindow(jsonEncode({
                      'args1': 'Sub window',
                      'args2': 100,
                      'args3': true,
                      'bussiness': 'bussiness_test',
                    }));
                    window
                      ..setFrame(const Offset(0, 0) & const Size(790, 720))
                      ..center()
                      ..setTitle('Another window')
                      ..show();
                  },
                  child: SvgPicture.asset(
                    'assets/images/TabBar_Folder.svg',
                    width: 30,
                    height: 30,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 18),
                SvgPicture.asset(
                  'assets/images/TabBar_SNS.svg',
                  width: 30,
                  height: 30,
                  color: Colors.black54,
                ),
              ],
            ),
            Column(
              children: [
                SvgPicture.asset(
                  'assets/images/TabBar_MiniProgram.svg',
                  width: 30,
                  height: 30,
                  color: Colors.black54,
                ),
                const SizedBox(height: 26),
                SvgPicture.asset(
                  'assets/images/icons_outlined_backup_cellphone.svg',
                  width: 30,
                  height: 30,
                  color: Colors.black,
                ),
                const SizedBox(height: 26),
                SvgPicture.asset(
                  'assets/images/TabBar_Setting.svg',
                  width: 30,
                  height: 30,
                  color: Colors.black54,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
