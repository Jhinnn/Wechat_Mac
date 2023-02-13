class ConversationModel {
  List<Conversation>? conversation;

  ConversationModel({this.conversation});

  ConversationModel.fromJson(Map<String, dynamic> json) {
    if (json['conversation'] != null) {
      conversation = <Conversation>[];
      json['conversation'].forEach((v) {
        conversation!.add(Conversation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (conversation != null) {
      data['conversation'] = conversation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Conversation {
  String? userId;
  String? userName;
  String? icon;
  String? content;
  bool? isSelf;

  Conversation(
      {this.userId, this.userName, this.icon, this.content, this.isSelf});

  Conversation.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    icon = json['icon'];
    content = json['content'];
    isSelf = json['isSelf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['icon'] = icon;
    data['content'] = content;
    data['isSelf'] = isSelf;
    return data;
  }
}

