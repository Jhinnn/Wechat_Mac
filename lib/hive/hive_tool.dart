import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wechat/hive/contacts_adapter.dart';
import 'package:wechat/hive/conversation_list_adapter.dart';

/// Hive 数据操作
class DBUtil {
  /// 实例
  static late DBUtil instance;

  /// 会话列表
  late Box conversationListBox;

  /// 会话
  late Box conversationBox;

  /// 会话
  late Box contactsBox;

  /// 初始化，需要在 main.dart 调用
  /// <https://docs.hivedb.dev/>
  static Future<void> install() async {
    /// 初始化数据库地址
    Directory document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);

    /// 注册自定义对象（实体）
    /// <https://docs.hivedb.dev/#/custom-objects/type_adapters>
    Hive.registerAdapter(ConversationListAdapters());
     Hive.registerAdapter(ContactsModelAdapters());
  }

  /// 初始化 Box
  static Future<DBUtil> getInstance() async {
    instance = DBUtil();
    await Hive.initFlutter();

    /// 标签
    instance.conversationListBox = await Hive.openBox('conversationList');

    /// 待办
    instance.conversationBox = await Hive.openBox('conversationBox');

    instance.contactsBox = await Hive.openBox('contactsBox');

    return instance;
  }
}
