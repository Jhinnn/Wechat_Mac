class ConversationListModel {
  List<ConversationList>? conversationList;

  ConversationListModel({this.conversationList});

  ConversationListModel.fromJson(Map<String, dynamic> json) {
    if (json['conversation_list'] != null) {
      conversationList = <ConversationList>[];
      json['conversation_list'].forEach((v) {
        conversationList!.add(ConversationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (conversationList != null) {
      data['conversation_list'] =
          conversationList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConversationList {
  String? userId;
  String? userName;
  String? icon;
  String? content;
  String? time;
  String? type;
  String? conversationId;
  bool? mute;
  List<Numbers>? numbers;

  ConversationList(
      {this.userId,
      this.userName,
      this.icon,
      this.content,
      this.time,
      this.type,
      this.conversationId,
      this.mute,
      this.numbers});

  ConversationList.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    icon = json['icon'];
    content = json['content'];
    time = json['time'];
    type = json['type'];
    conversationId = json['conversation_id'];
    mute = json['mute'];
    if (json['numbers'] != null) {
      numbers = <Numbers>[];
      json['numbers'].forEach((v) {
        numbers!.add(Numbers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['icon'] = icon;
    data['content'] = content;
    data['time'] = time;
    data['type'] = type;
    data['conversation_id'] = conversationId;
    data['mute'] = mute;
    if (numbers != null) {
      data['numbers'] = numbers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Numbers {
  String? userId;
  String? userName;
  String? icon;

  Numbers({this.userId, this.userName, this.icon});

  Numbers.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['icon'] = icon;
    return data;
  }
}

