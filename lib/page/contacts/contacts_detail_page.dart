import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:wechat/hive/contacts_adapter.dart';

class ContactsDetailPage extends ConsumerWidget {
  final ContactsModel contactsModel;
  const ContactsDetailPage({required this.contactsModel, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.fromLTRB(100, 100, 100, 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 10),
                      Text(contactsModel.wechatName,
                          style: const TextStyle(
                              fontSize: 22,
                              color: Color.fromRGBO(29, 30, 29, 0.929),
                              fontWeight: FontWeight.normal)),
                      const SizedBox(height: 26),
                      const Text('我的人生我做主',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(153, 160, 153, 0.922),
                              fontWeight: FontWeight.normal))
                    ],
                  )),
                  const SizedBox(
                    width: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: RandomAvatar(
                      contactsModel.contactName,
                      height: 85,
                      width: 85,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: Color.fromARGB(255, 230, 219, 219),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(153, 160, 153, 0.922),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                              height: 30,
                              child: Text(
                                '备注名',
                              )),
                          const SizedBox(
                              height: 30,
                              child: Text(
                                '地区',
                              )),
                          const SizedBox(
                              height: 30,
                              child: Text(
                                '微信号',
                              )),
                          const SizedBox(
                              height: 30,
                              child: Text(
                                '来源',
                              )),
                          contactsModel.lable == null
                              ? Container()
                              : const SizedBox(
                                  height: 30,
                                  child: Text(
                                    '标签',
                                  )),
                          const SizedBox(
                              height: 30,
                              child: Text(
                                '朋友圈权限',
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  DefaultTextStyle(
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: 30,
                              child: Text(contactsModel.contactName)),
                          SizedBox(
                              height: 30, child: Text(contactsModel.address)),
                          SizedBox(
                              height: 30, child: Text(contactsModel.wechat)),
                          SizedBox(
                              height: 30, child: Text(contactsModel.source)),
                          contactsModel.lable == null
                              ? Container()
                              : SizedBox(
                                  height: 30,
                                  child: Text(contactsModel.lable!)),
                          SizedBox(
                              height: 30,
                              child: Text(contactsModel.jurisdiction)),
                        ],
                      )),
                ],
              ),
              const Divider(
                color: Color.fromARGB(255, 230, 219, 219),
              ),
            ],
          ),

          TextButton (
                    onPressed: () {},
                    style: ButtonStyle(
                      fixedSize:MaterialStateProperty.all<Size>(const Size(140, 36)), 
                      backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 22, 187, 7)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: const Text("发消息")
                )
//更多请阅读：https://www.yiibai.com/flutter/flutter-textbutton.html


        ],
      ),
    );
  }
}
