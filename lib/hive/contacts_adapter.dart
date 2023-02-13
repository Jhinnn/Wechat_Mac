import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class ContactsModel {
  ContactsModel({
    required this.userID,
    required this.contactName,
    required this.wechatName,
    required this.userIcon,
    required this.sex,
    required this.introduction,
    required this.address,
    required this.wechat,
    required this.source,
    this.lable,
    required this.jurisdiction,
    required this.moments,
  });

  @HiveField(0)
  late String userID;

  @HiveField(1)
  late String contactName;

  @HiveField(2)
  late String wechatName;

  @HiveField(3)
  late String userIcon;

  @HiveField(4)
  late int sex;

  @HiveField(5)
  late String introduction;

  @HiveField(6)
  late String address;

  @HiveField(7)
  late String wechat;

  @HiveField(8)
  late String source;

  @HiveField(9)
  String? lable;

  @HiveField(10)
  late String jurisdiction;
  @HiveField(11)
  late String moments;
}

class ContactsModelAdapters extends TypeAdapter<ContactsModel> {
  @override
  int get typeId => 2;

  @override
  void write(BinaryWriter writer, ContactsModel obj) {
    writer.write(obj.userID);
    writer.write(obj.contactName);
    writer.write(obj.wechatName);
    writer.write(obj.userIcon);
    writer.write(obj.sex);
    writer.write(obj.introduction);
    writer.write(obj.address);
    writer.write(obj.wechat);
    writer.write(obj.source);
    writer.write(obj.lable);
    writer.write(obj.jurisdiction);
    writer.write(obj.moments);
  }

  @override
  ContactsModel read(BinaryReader reader) {
    return ContactsModel(
      userID: reader.read(),
      contactName: reader.read(),
      wechatName: reader.read(),
      userIcon: reader.read(),
      sex: reader.read(),
      introduction: reader.read(),
      address: reader.read(),
      wechat: reader.read(),
      source: reader.read(),
      lable: reader.read(),
      jurisdiction: reader.read(),
      moments: reader.read(),
    );
  }
}
