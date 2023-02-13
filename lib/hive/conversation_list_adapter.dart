import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class ConversationListModel {
  ConversationListModel(
      {required this.conversationId,
      required this.userID,
      required this.userName,
      required this.content,
      required this.userIcon,
      required this.conversationType,
      required this.isMute,
      required this.time,
      this.groupMemberList});
  @HiveField(0)
  late String conversationId;

  @HiveField(1)
  late String userID;

  @HiveField(2)
  late String userName;

  @HiveField(3)
  late String content;

  @HiveField(4)
  late String userIcon;

  @HiveField(5)
  late int conversationType;

  @HiveField(6)
  late int isMute;

  @HiveField(6)
  late String time;

  @HiveField(7)
  List<GroupMemberModel>? groupMemberList;
}

class GroupMemberModel {
  GroupMemberModel({
    required this.userID,
    required this.userName,
    required this.userIcon,
  });
  @HiveField(0)
  late String userID;

  @HiveField(1)
  late String userName;

  @HiveField(2)
  late String userIcon;
}

class ConversationListAdapters extends TypeAdapter<ConversationListModel> {
  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, ConversationListModel obj) {
    writer.write(obj.conversationId);
    writer.write(obj.userID);
    writer.write(obj.userName);
    writer.write(obj.content);
    writer.write(obj.userIcon);
    writer.write(obj.conversationType);
    writer.write(obj.isMute);
    writer.write(obj.time);
    writer.write(obj.groupMemberList);
  }

  @override
  ConversationListModel read(BinaryReader reader) {
    return ConversationListModel(
      conversationId: reader.read(),
      userID: reader.read(),
      userName: reader.read(),
      content: reader.read(),
      userIcon: reader.read(),
      conversationType: reader.read(),
      isMute: reader.read(),
      time: reader.read(),
      groupMemberList: reader.read(),
    );
  }
}
