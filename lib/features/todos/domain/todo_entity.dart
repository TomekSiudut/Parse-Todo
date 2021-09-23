import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final String? id;
  final String? title;
  final bool? priority;

  TodoEntity({this.id, this.title, this.priority});

  @override
  List<Object?> get props => [id, title, priority];
}
