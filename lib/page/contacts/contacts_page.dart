import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:random_string/random_string.dart';
import 'package:username/username.dart';
import 'package:wechat/hive/contacts_adapter.dart';
import 'package:wechat/hive/hive_tool.dart';
import 'package:wechat/page/contacts/contacts_detail_page.dart';

final contactProvider = StateProvider<int?>((ref) => null);

class ContactsPage extends StatefulWidget {
  final DBUtil? dbUtil;
  const ContactsPage({Key? key, this.dbUtil}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    List<ContactsModel> result =
        widget.dbUtil!.contactsBox.values.toList().cast<ContactsModel>();
    return Row(
      children: [
        Container(
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
                        ContactsModel conversationListModel = ContactsModel(
                            userID: randomAlphaNumeric(20),
                            address: '湖北武汉',
                            contactName: Username.cn().fullname,
                            introduction: randomAlphaNumeric(40),
                            moments: randomAlphaNumeric(20),
                            sex: 1,
                            jurisdiction: randomAlphaNumeric(20),
                            source: randomAlphaNumeric(13),
                            userIcon:
                                'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fblog%2F202103%2F23%2F20210323132934_d2473.thumb.1000_0.png&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1678416650&t=3fa34a17cfe6aa35381f56df9b6beb4e',
                            wechat: randomAlphaNumeric(8),
                            wechatName: randomAlphaNumeric(5));

                        widget.dbUtil?.contactsBox.add(conversationListModel);
                      },
                      child: Container(
                          width: 26,
                          height: 26,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(233, 233, 233, 1),
                              borderRadius: BorderRadius.circular(4)),
                          child: const Icon(Icons.person_add_sharp,
                              size: 18, color: Colors.grey)),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 13),
                      child: Container(
                        width: 228,
                        height: 40,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add_reaction_sharp,
                              size: 16,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              '通讯录管理',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      padding:
                          const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            '联系人',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    widget.dbUtil != null
                        ? ValueListenableBuilder(
                            valueListenable:
                                widget.dbUtil!.contactsBox.listenable(),
                            builder: (context, value, child) {
                              List<ContactsModel> result =
                                  value.values.toList().cast<ContactsModel>();

                              return Consumer(
                                builder: (context, ref, child) {
                                  int? selctedInt = ref.watch(contactProvider);
                                  return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      controller: _scrollController,
                                      itemCount: result.length,
                                      itemBuilder: ((context, index) {
                                        ContactsModel contactsModel =
                                            result[index];
                                        return InkWell(
                                          onTap: () {
                                            ref
                                                .read(contactProvider.notifier)
                                                .update((state) => index);
                                          },
                                          child: Container(
                                            height: 58,
                                            color: selctedInt == index
                                                ? const Color.fromRGBO(
                                                    209, 209, 209, 1)
                                                : Colors.white,
                                            padding: const EdgeInsets.only(
                                                left: 34, top: 5, bottom: 5),
                                            child: Row(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl:
                                                      contactsModel.userIcon,
                                                  width: 32,
                                                  height: 32,
                                                ),
                                                // RandomAvatar(
                                                //   contactsModel.contactName,
                                                //   height: 32,
                                                //   width: 32,
                                                // ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  contactsModel.contactName,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Color.fromRGBO(
                                                          29, 30, 29, 0.929),
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }));
                                },
                              );
                            })
                        : Container(),
                  ],
                ),
              ))
              // Expanded(
              //   child: GroupedListView<dynamic, String>(
              //     elements: _elements,
              //     groupBy: (element) => element['group'],
              //     groupComparator: (value1, value2) => value2.compareTo(value1),
              //     itemComparator: (item1, item2) =>
              //         item1['name'].compareTo(item2['name']),
              //     order: GroupedListOrder.DESC,
              //     useStickyGroupSeparators: true,
              //     groupSeparatorBuilder: (String value) => Padding(
              //       padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              //       child: Row(
              //         children: [
              //           const Icon(
              //             Icons.arrow_forward_ios,
              //             size: 16,
              //             color: Colors.grey,
              //           ),
              //           const SizedBox(
              //             width: 4,
              //           ),
              //           Text(
              //             value,
              //             style: const TextStyle(
              //                 fontSize: 13, fontWeight: FontWeight.bold),
              //           ),
              //         ],
              //       ),
              //     ),
              //     itemBuilder: (c, element) {
              //       return Container(
              //         height: 58,
              //         padding: const EdgeInsets.only(left: 30, top: 5, bottom: 5),
              //         child: Row(
              //           children: [
              //             Image.asset('assets/images/avatars.png', width: 34),
              //             const SizedBox(
              //               width: 10,
              //             ),
              //              Text(
              //               element['name'],
              //               style: const TextStyle(
              //                   fontSize: 14,
              //                   color: Color.fromRGBO(29, 30, 29, 0.929),
              //                   fontWeight: FontWeight.normal),
              //             ),
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // )
            ],
          ),
        ),
        const VerticalDivider(
          color: Color.fromRGBO(228, 223, 222, 1),
          thickness: 0,
          width: 1,
        ),
        Expanded(child: Consumer(builder: (context, ref, child) {
          int? selctedInt = ref.watch(contactProvider);
          return selctedInt == null
              ? Container()
              : ContactsDetailPage(
                  contactsModel: result[selctedInt],
                );
        }))
      ],
    );
  }
}
