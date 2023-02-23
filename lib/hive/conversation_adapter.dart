import 'package:hive/hive.dart';

@HiveType(typeId: 4)
class ConversationModel {
  ConversationModel(
      {required this.conversationMap});

  @HiveField(0)
  late Map<String, List<Conversation>> conversationMap;
}

class ConversationModelAdapters extends TypeAdapter<ConversationModel> {
  @override
  int get typeId => 4;

  @override
  void write(BinaryWriter writer, ConversationModel obj) {
    writer.write(obj.conversationMap);
  }

  @override
  ConversationModel read(BinaryReader reader) {
    return ConversationModel(conversationMap: reader.read());
  }
}

@HiveType(typeId: 3)
class Conversation {
  Conversation({
    required this.conversationId,
    required this.messageId,
    required this.userID,
    required this.userName,
    required this.content,
    required this.userIcon,
    required this.conversationType,
    required this.isSelf,
    required this.time,
  });
  @HiveField(0)
  late String conversationId;

  @HiveField(1)
  late String messageId;

  @HiveField(2)
  late String userID;

  @HiveField(3)
  late String userName;

  @HiveField(4)
  late String content;

  @HiveField(5)
  late String userIcon;

  @HiveField(6)
  late int conversationType;

  @HiveField(7)
  late bool isSelf;

  @HiveField(8)
  late String time;
}

class ConversationAdapters extends TypeAdapter<Conversation> {
  @override
  int get typeId => 3;

  @override
  void write(BinaryWriter writer, Conversation obj) {
    writer.write(obj.conversationId);
    writer.write(obj.messageId);
    writer.write(obj.userID);
    writer.write(obj.userName);
    writer.write(obj.content);
    writer.write(obj.userIcon);
    writer.write(obj.conversationType);
    writer.write(obj.isSelf);
    writer.write(obj.time);
  }

  @override
  Conversation read(BinaryReader reader) {
    return Conversation(
      conversationId: reader.read(),
      messageId: reader.read(),
      userID: reader.read(),
      userName: reader.read(),
      content: reader.read(),
      userIcon: reader.read(),
      conversationType: reader.read(),
      isSelf: reader.read(),
      time: reader.read(),
    );
  }
}
