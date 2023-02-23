import 'dart:convert';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/hive/conversation_list_adapter.dart';
import 'package:wechat/page/collect/collect_page.dart';
import 'package:wechat/page/conversation/wechat_conversation_list_page.dart';
import 'package:wechat/hive/hive_tool.dart';
import 'package:flutter_svg/svg.dart';
import 'contacts/contacts_page.dart';

final conversationIndex = StateProvider<int>((ref) => 1); //选择的聊天的对象
final conversationModelProvider =
    StateProvider<ConversationListModel?>((ref) => null);
final tabbarSelectedIndex = StateProvider<int>((ref) => 1);
final pageIndexProvider = StateProvider<int>((ref) => 0);

class WechatHomePage extends StatefulWidget {
  const WechatHomePage({Key? key}) : super(key: key);

  @override
  State<WechatHomePage> createState() => _WechatHomePageState();
}

class _WechatHomePageState extends State<WechatHomePage> {
  DBUtil? dbUtil;

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
                WechatConversataionPage(dbUtil: dbUtil),
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
                      'args1': 'file window',
                      'args2': 0,
                      'args3': true,
                      'bussiness': 'bussiness_test',
                    }));
                    window
                      ..setFrame(const Offset(0, 0) & const Size(810, 700))
                      ..center()
                      ..setTitle('file window')
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
                InkWell(
                  onTap: () async {
                    final window =
                        await DesktopMultiWindow.createWindow(jsonEncode({
                      'args1': 'sns window',
                      'args2': 1,
                      'args3': true,
                      'bussiness': 'bussiness_test',
                    }));
                    window
                      ..setFrame(const Offset(0, 0) & const Size(550, 600))
                      ..center()
                      ..setTitle('sns window')
                      ..show();
                  },
                  child: SvgPicture.asset(
                    'assets/images/TabBar_SNS.svg',
                    width: 30,
                    height: 30,
                    color: Colors.black54,
                  ),
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
