class SNSModel {
  List<Sns>? sns;

  SNSModel({this.sns});

  SNSModel.fromJson(Map<String, dynamic> json) {
    if (json['sns'] != null) {
      sns = <Sns>[];
      json['sns'].forEach((v) {
        sns!.add(Sns.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sns != null) {
      data['sns'] = sns!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sns {
  String? userName;
  String? icon;
  String? content;
  int? type;
  List<String>? image;
  String? linkImage;
  String? linkContitle;
  String? linkUrl;

  Sns(
      {this.userName,
      this.icon,
      this.content,
      this.type,
      this.image,
      this.linkImage,
      this.linkContitle,
      this.linkUrl});

  Sns.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    icon = json['icon'];
    content = json['content'];
    type = json['type'];
    image = json['image'].cast<String>();
    linkImage = json['link_image'];
    linkContitle = json['link_contitle'];
    linkUrl = json['link_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['icon'] = icon;
    data['content'] = content;
    data['type'] = type;
    data['image'] = image;
    data['link_image'] = linkImage;
    data['link_contitle'] = linkContitle;
    data['link_url'] = linkUrl;
    return data;
  }
}
