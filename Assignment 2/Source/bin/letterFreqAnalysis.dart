import 'dart:io';

class LetterFreqAnalysis {
  //Only works for upper case letters
  static String crack(String input) {
    //Hardcoded frequencies in custom map (normal map does not have a order)
    List<_KeyValuePair> map = List.generate(26, (i) => _KeyValuePair(i, 0));
    map[0].value = 8.167; //A
    map[1].value = 1.492; //B
    map[2].value = 2.782; //C
    map[3].value = 4.253; //...
    map[4].value = 12.702;
    map[5].value = 2.228;
    map[6].value = 2.015;
    map[7].value = 6.094;
    map[8].value = 6.966;
    map[9].value = 0.153;
    map[10].value = 0.772;
    map[11].value = 4.025;
    map[12].value = 2.406;
    map[13].value = 6.749;
    map[14].value = 7.507;
    map[15].value = 1.929;
    map[16].value = 0.095;
    map[17].value = 5.987;
    map[18].value = 6.327;
    map[19].value = 9.056;
    map[20].value = 2.758;
    map[21].value = 0.978;
    map[22].value = 2.360;
    map[23].value = 0.150;
    map[24].value = 1.974;
    map[25].value = 0.074; //Z
    map.sort((a, b) => a.value.compareTo(b.value)); //Sort by frequency

    final List<_KeyValuePair> crackFreq =
        List.generate(26, (i) => _KeyValuePair(i, 0));
    for (var item in input.codeUnits) {
      item -= 65;
      if (item >= 0 && item < 26)
        crackFreq[item].value++; //Only test for count A to Z
    }
    crackFreq.sort((a, b) => a.value.compareTo(b.value)); //Sort by count

    //Simply substitute based on order
    var buf = StringBuffer();
    for (var item in input.codeUnits) {
      item -= 65; //convert to local space (0=A...26=Z)
      if (item >= 0 && item < 26) {
        int index = crackFreq.indexWhere((kv) => kv.key == item);
        buf.writeCharCode(map[index].key + 65);
      } else {
        buf.write(' ');
      }
    }
    return buf.toString();
  }

  //Only works for upper case letters
  //just enter the two letters you want to switch in the console
  //enter . when your done
  static String interactiveCrack(String input) {
    //interactivly replace letters
    String output = crack(input);
    print(output);
    String op = stdin.readLineSync();
    while (op != ".") {
      if (op.isNotEmpty && op.length >= 2) {
        op = op.replaceAll(RegExp(" "), "").toUpperCase();
        output = output.replaceAll(RegExp(op[0]), "~");
        output = output.replaceAll(RegExp(op[1]), op[0]);
        output = output.replaceAll(RegExp("~"), op[1]);
        print(output);
        print("Switched: " + op[0] + "~" + op[1]);
      }
      op = stdin.readLineSync();
    }
    return output;
  }
}

//Helper class for custom map
class _KeyValuePair {
  int key;
  double value;
  _KeyValuePair(this.key, this.value) {}
}
