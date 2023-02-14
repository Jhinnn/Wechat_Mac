import 'package:cached_network_image/cached_network_image.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final collectProvider = StateProvider<int>((ref) => 0);

class DocumentPage extends ConsumerWidget {
  DocumentPage({
    Key? key,
    required this.windowController,
    required this.args,
  }) : super(key: key);

  final WindowController windowController;
  final Map? args;

  List<String> collectList = ['全部', '最近使用', '筛选', '发送者', '聊天', '类型'];
  List<String> collectImageList = [
    'cwenjian',
    'cquanbu',
    'ctupian',
    'clianjie',
    'cbiji',
    'cyuyin',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selctedInt = ref.watch(collectProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              height: 34,
              color: const Color.fromRGBO(227, 222, 222, 1),
              padding: const EdgeInsets.only(left: 400, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Center(
                      child: Text(
                    '聊天文件',
                    style: TextStyle(
                        fontSize: 13, color: Color.fromRGBO(99, 96, 96, 1)),
                  )),
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
                        fillColor: const Color.fromARGB(255, 248, 247, 247),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: const Color.fromRGBO(247, 247, 247, 1),
                    width: 130,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        if (index == 2) {
                          return Container(
                              padding: const EdgeInsets.only(left: 13),
                              child: Text(
                                collectList[index],
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 196, 187, 187),
                                    fontSize: 13),
                              ));
                        } else {
                          return InkWell(
                            onTap: () {
                              ref
                                  .read(collectProvider.notifier)
                                  .update((state) => state = index);
                            },
                            child: Container(
                                height: 50,
                                color: selctedInt == index
                                    ? const Color.fromRGBO(209, 209, 209, 1)
                                    : const Color.fromRGBO(247, 247, 247, 1),
                                padding: const EdgeInsets.only(left: 13),
                                child: Row(children: [
                                  Image.asset(
                                    'assets/images/${collectImageList[index]}.png',
                                    width: 21,
                                    height: 21,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    collectList[index],
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 46, 45, 45),
                                        fontSize: 14),
                                  )
                                ])),
                          );
                        }
                      },
                      itemCount: collectList.length,
                    ),
                  ),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(80, 20, 80, 0),
                          child: Text('本月',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                        ),
                        Expanded(
                            child: ListView.builder(
                                itemCount: 10,
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsets.fromLTRB(80, 20, 80, 0),
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 70,
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.file_copy,
                                              size: 35,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            SizedBox(
                                              height: 40,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: const [
                                                  Text('google.dmg',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Color.fromRGBO(
                                                              16,
                                                              17,
                                                              16,
                                                              0.922),
                                                          fontWeight: FontWeight
                                                              .normal)),
                                                  Text('来自：相亲相爱一家人',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color.fromRGBO(
                                                              114,
                                                              116,
                                                              114,
                                                              0.922),
                                                          fontWeight: FontWeight
                                                              .normal)),
                                                ],
                                              ),
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    const Text('2023/01/29',
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            color:
                                                                Color.fromRGBO(
                                                                    180,
                                                                    184,
                                                                    180,
                                                                    0.922),
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal)),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                        '${index.toString()}MB',
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Color.fromRGBO(
                                                              122,
                                                              124,
                                                              122,
                                                              0.922),
                                                        ))
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        const Spacer(),
                                        const Divider(
                                          color:
                                              Color.fromRGBO(228, 223, 222, 1),
                                          thickness: 0,
                                          height: 1,
                                        ),
                                      ],
                                    ),
                                  );
                                })),
                      ]))
                ],
              ),
            )
            // if (args != null)
            //   Text(
            //     'Arguments: ${args.toString()}',
            //     style: const TextStyle(fontSize: 20),
            //   ),
            // ValueListenableBuilder<bool>(
            //   valueListenable: DesktopLifecycle.instance.isActive,
            //   builder: (context, active, child) {
            //     if (active) {
            //       return const Text('Window Active');
            //     } else {
            //       return const Text('Window Inactive');
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
