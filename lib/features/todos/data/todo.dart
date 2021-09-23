import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:todo/features/todos/domain/todo_entity.dart';

class Todo extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'Todo';
  static const String keyCreatedAt = "createdAt";
  static const String keyObjectId = 'objectId';
  static const String keyTitle = 'title';
  static const String keyPriority = "priority";

  Todo() : super(_keyTableName);

  Todo.clone() : this();

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

  @override
  Todo clone(Map<String, dynamic> map) => Todo.clone()..fromJson(map);

  @override
  Todo fromJson(Map<String, dynamic> objectData) {
    super.fromJson(objectData);
    return this;
  }

  String? get objectId => get<String?>(keyObjectId);

  set objectId(String? objectId) => set<String?>(keyObjectId, objectId);

  DateTime? get createdAt => get<DateTime?>(keyCreatedAt)?.toLocal();

  set createdAt(DateTime? createdAt) => set<DateTime?>(keyCreatedAt, createdAt);

  String? get title => get<String?>(keyTitle);

  set title(String? title) => set<String?>(keyTitle, title);

  bool? get priority => get<bool?>(keyPriority);

  set priority(bool? priority) => set<bool?>(keyPriority, priority);
}

extension Mapping on Todo {
  TodoEntity mapToEntity() =>
      TodoEntity(title: this.title, priority: this.priority);
}
