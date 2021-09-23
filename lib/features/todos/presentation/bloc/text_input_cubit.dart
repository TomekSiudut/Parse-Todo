import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
part 'text_input_state.dart';

class TextInputCubit extends Cubit<TextInputState> {
  TextInputCubit() : super(TextInputInitial());

  String? _value = "";

  getValue() => _value;

  onChanged(String text) {
    _value = text;
    emit(TextInputInitial());
    print(_value);
  }
}
