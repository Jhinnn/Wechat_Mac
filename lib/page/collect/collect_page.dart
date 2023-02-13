import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/page/collect/collect_detail_page.dart';

final collectIndexProvider = StateProvider<int>((ref) => 0);

class CollectPage extends StatefulWidget {
  const CollectPage({Key? key}) : super(key: key);

  @override
  State<CollectPage> createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage> {
  List<String> collectList = ['全部收藏', '图片与视频', '链接', '笔记', '文件', '语音', '聊天记录'];
  List<String> collectImageList = [
    'cquanbu',
    'ctupian',
    'clianjie',
    'cbiji',
    'cwenjian',
    'cyuyin',
    'cchat'
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      int selctedInt = ref.watch(collectIndexProvider);
      return Row(
        children: [
          Container(
              width: 250,
              color: const Color.fromRGBO(247, 247, 247, 1),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              maxWidth: 224,
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
                                fillColor:
                                    const Color.fromRGBO(233, 233, 233, 1),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 13),
                      child: Container(
                        width: 222,
                        height: 40,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add_circle_outline,
                              size: 18,
                              color: Color.fromARGB(255, 172, 166, 166),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              '新建笔记',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            ref
                                .read(collectIndexProvider.notifier)
                                .update((state) => state = index);
                          },
                          child: Container(
                              height: 40,
                              color: selctedInt == index
                                  ? const Color.fromRGBO(209, 209, 209, 1)
                                  : const Color.fromRGBO(247, 247, 247, 1),
                              padding: const EdgeInsets.only(left: 13),
                              child: Row(children: [
                                Image.asset(
                                  'assets/images/${collectImageList[index]}.png',
                                  width: 20,
                                  height: 20,
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
                      },
                      itemCount: collectList.length,
                    )
                  ])),
          const VerticalDivider(
            color: Color.fromRGBO(228, 223, 222, 1),
            thickness: 0,
            width: 1,
          ),
          Expanded(
              child: CollectDetailPage(
            title: collectList[selctedInt],
          ))
        ],
      );
    });
  }
}
