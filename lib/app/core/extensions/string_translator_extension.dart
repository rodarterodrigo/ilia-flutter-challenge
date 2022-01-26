import 'package:translator/translator.dart';

extension StringTranslatorExtension on String {
  String get translateTo {
    String string = '';
    translate(to: 'pt').then((value) => string = value.text).whenComplete(() => string);
    return string;
  }
}