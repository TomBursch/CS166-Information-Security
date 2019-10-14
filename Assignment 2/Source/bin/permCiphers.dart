import 'dart:math';

abstract class PermutationCipher {
  final int _key;

  PermutationCipher(this._key);

  //abstract methods
  int _project(int val, {bool reverse = false});
  bool isValidChar(int c);

  //---Implementations---
  String encrypt(String plain,
      {bool replaceUnsupportedChar = false, String replaceBy = " "}) {
    var buf = StringBuffer();
    for (var item in plain.toUpperCase().codeUnits) {
      if (isValidChar(item))
        buf.writeCharCode(_project(item));
      else if (!replaceUnsupportedChar)
        buf.writeCharCode(item);
      else if (replaceUnsupportedChar) buf.write(replaceBy);
    }
    //remove all duplicated replaces (typically replaceBy is a space, this prevents long spaces in the text)
    if (replaceUnsupportedChar)
      return buf.toString().replaceAll(RegExp(replaceBy + "+"), replaceBy);

    return buf.toString();
  }

  String decrypt(String cipher, {bool removeUnsupportedChar = false}) {
    var buf = StringBuffer();
    for (var item in cipher.codeUnits) {
      if (isValidChar(item))
        buf.writeCharCode(_project(item, reverse: true));
      else if (!removeUnsupportedChar) buf.writeCharCode(item);
    }
    return buf.toString();
  }
}

class SubsCipherUpperLetters extends PermutationCipher {
  List<int> _map;

  SubsCipherUpperLetters(int key) : super(key) {
    _map = List.generate(26, (i) => i);
    _map.shuffle(Random(_key));
  }

  int _project(int val, {bool reverse = false}) {
    val -= 65;
    if (val < 0 || val >= 26) return 32;
    if (reverse) {
      return _map.indexWhere((i) => i == val) + 65;
    } else {
      return _map[val] + 65;
    }
  }

  bool isValidChar(int c) {
    c -= 65;
    return c >= 0 && c < 26;
  }
}

class SubsCipherUnicode extends PermutationCipher {
  List<int> _map;

  SubsCipherUnicode(int key) : super(key) {
    _map = List.generate(pow(2, 16), (i) => i);
    _map.shuffle(Random(key));
  }

  int _project(int val, {bool reverse = false}) {
    if (reverse) {
      return _map.indexWhere((i) => i == val);
    } else {
      return _map[val];
    }
  }

  bool isValidChar(int c) => true;
}
