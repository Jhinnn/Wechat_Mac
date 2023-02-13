import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectDetailPage extends ConsumerWidget {
  final String title;
  const CollectDetailPage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
        height: 60,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: const TextStyle(color: Colors.black, fontSize: 16)),
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
          child: ListView.builder(
              itemCount: 10,
              padding: const EdgeInsets.fromLTRB(80, 20, 80, 0),
              itemBuilder: (context, index) {
                return Container(
                  height: 120,
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                'https://img2.baidu.com/it/u=3548083016,3260658880&fm=253&fmt=auto&app=120&f=JPEG?w=641&h=480',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('收废品能挣多少钱？',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromRGBO(16, 17, 16, 0.922),
                                        fontWeight: FontWeight.normal)),
                                Text('基本都是老乡',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromRGBO(
                                            114, 116, 114, 0.922),
                                        fontWeight: FontWeight.normal)),
                                Spacer(),
                                Text('www.baidu.com',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color:
                                          Color.fromRGBO(122, 124, 122, 0.922),
                                    ))
                              ],
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Column(
                                children: const [
                                  Text('2023/01/29',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(
                                              114, 116, 114, 0.922),
                                          fontWeight: FontWeight.normal)),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text('来自:虎嗅',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromRGBO(
                                            122, 124, 122, 0.922),
                                      ))
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      const Spacer(),
                      const Divider(
                        color: Color.fromRGBO(228, 223, 222, 1),
                        thickness: 0,
                        height: 1,
                      ),
                    ],
                  ),
                );
              })),
    ]);
  }
}
