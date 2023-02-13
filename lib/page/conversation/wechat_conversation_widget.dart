import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:wechat/hive/conversation_list_adapter.dart';
import 'package:wechat/page/wechat_home_page.dart';

class WechatConversataionWidget extends ConsumerWidget {
  const WechatConversataionWidget(
      {super.key,required this.onTap, required this.result});
  final Function(int) onTap;
  final List<ConversationListModel> result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selectedIndex = ref.watch(conversationSelectedIndex);
    return ListView.builder(
        itemCount: result.length,
        itemBuilder: (_, index) {
          ConversationListModel conversationList = result[index];
          return InkWell(
            onTap: () {
              ref
                  .read(conversationSelectedIndex.notifier)
                  .update((state) => state = index);
              // onTap(index);
            },
            child: Container(
              padding: const EdgeInsets.only(
                left: 12,
                right: 8,
              ),
              color: selectedIndex == index
                  ? const Color.fromRGBO(209, 209, 209, 1)
                  : Colors.white,
              height: 68,
              child: Row(
                children: [
                  // conversationList.conversationType == 1
                  //     ? ClipRRect(
                  //         borderRadius: BorderRadius.circular(4),
                  //         child: CachedNetworkImage(
                  //           imageUrl: conversationList.userIcon,
                  //           width: 35,
                  //           height: 35,
                  //         ))
                  //     : ClipRRect(
                  //         borderRadius: BorderRadius.circular(4),
                  //         child: CachedNetworkImage(
                  //           imageUrl: conversationList
                  //               .groupMemberList!.first.userIcon,
                  //           width: 35,
                  //           height: 35,
                  //         )),
                  RandomAvatar(conversationList.userName,
                      height: 35, width: 35, fit: BoxFit.fitWidth),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 38,
                    width: 182,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(conversationList.userName,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14)),
                            Text(conversationList.time.substring(11, 16),
                                style: TextStyle(
                                    color: selectedIndex == index
                                        ? Colors.grey[500]
                                        : Colors.grey[400],
                                    fontSize: 10.5))
                          ],
                        ),
                        Text(conversationList.content,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: selectedIndex == index
                                    ? Colors.grey[500]
                                    : Colors.grey[400],
                                fontSize: 12))
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
