import 'dart:convert';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/models/sns_model.dart';

final collectProvider = StateProvider<int>((ref) => 0);

class SNSPage extends ConsumerWidget {
  const SNSPage({
    Key? key,
    required this.windowController,
    required this.args,
  }) : super(key: key);

  final WindowController windowController;
  final Map? args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 340,
                    child: Column(
                      children: [
                        Image.network(
                          'https://img1.baidu.com/it/u=4049022245,514596079&fm=253&fmt=auto&app=120&f=JPEG?w=889&h=500',
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.only(right: 20),
                    color: Colors.transparent,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.refresh,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Icon(
                            Icons.notifications_none_sharp,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ]),
                  ),
                  Positioned(
                    right: 30,
                    bottom: 30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        'assets/images/avatars.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                  const Positioned(
                    right: 110,
                    bottom: 50,
                    child: Text(
                      '张三李四',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  )
                ],
              ),
              FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString('assets/json/sns.json'),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      SNSModel snsModel = SNSModel.fromJson(
                          json.decode(snapshot.data.toString()));
                      return ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: Color.fromRGBO(228, 223, 222, 1),
                              thickness: 0,
                              indent: 50,
                              height: 1,
                            );
                          },
                          padding: const EdgeInsets.only(
                              left: 20, top: 0, right: 20),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            Sns sns = snsModel.sns![index];
                            return Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 15, top: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(sns.icon!,
                                        width: 37, height: 37),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        sns.userName!,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 94, 107, 146),
                                            fontSize: 14),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      if (sns.content!.isNotEmpty)
                                        SizedBox(
                                          width: 450,
                                          child: Text(
                                            sns.content!,
                                            maxLines: 10,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      snsWidget(sns),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text('4天前',
                                          style: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 12)),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          itemCount: snsModel.sns!.length);
                    } else {
                      return Container();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  snsWidget(Sns sns) {
    if (sns.type == 0) {
      return Container();
    } else if (sns.type == 1) {
      if (sns.image!.length == 1) {
        return Image.network(
          sns.image!.first,
          width: 230,
          height: 400,
          fit: BoxFit.cover,
        );
      } else {
        return SizedBox(
          width: 450,
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: sns.image!.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (context, index) {
                return Image.network(
                  sns.image![index],
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                );
              }),
        );
      }
    } else {
      return Container(
        width: 330,
        height: 60,
        decoration: BoxDecoration(color: Colors.grey[100]),
        padding: const EdgeInsets.all(9),
        child: Row(
          children: [
            Image.network(
              sns.linkImage!,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                sns.linkContitle!,
                maxLines: 2,
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
          ],
        ),
      );
    }
  }
}
