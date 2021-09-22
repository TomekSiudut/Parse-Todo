import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:todo/features/todos/domain/todo_entity.dart';

class Todo extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'Todo';
  static const String keyObjectId = 'objectId';
  static const String keyTitle = 'title';
  static const String keyPriority = "priority";

  @override
  Map<String, dynamic> toJson({
    bool? full,
    bool forApiRQ = false,
    bool allowCustomObjectId = false,
  }) {
    return super.toJson(
        full: full ?? true,
        forApiRQ: forApiRQ,
        allowCustomObjectId: allowCustomObjectId);
  }

  Todo() : super(_keyTableName);

  String? get objectId => get<String?>(keyObjectId);

  set objectId(String? objectId) => set<String?>(keyObjectId, objectId);

  String? get title => get<String?>(keyTitle);

  set title(String? title) => set<String?>(keyTitle, title);

  bool? get priority => get<bool?>(keyPriority);

  set priority(bool? priority) => set<bool?>(keyPriority, priority);
}

extension Mapping on Todo {
  TodoEntity mapToEntity() => TodoEntity(
        id: objectId ?? "",
        title: this.title,
        priority: this.priority,
      );
}
