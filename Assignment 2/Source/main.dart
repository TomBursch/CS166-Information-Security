import 'dart:io';
import 'bin/letterFreqAnalysis.dart';
import 'bin/permCiphers.dart';

//Input options:
//dart main
//-f <FilePath>
//-t <String>
main(List<String> args) async {
  String s;
  if(args.isNotEmpty && args[0].endsWith('f')) s = await File(args[1]).readAsString();
  else if (args.isNotEmpty && args[0].endsWith('t')) s = args[1];
  else s = await File("HarryPotter_FirstChapter.txt").readAsString();
  
  var cip = SubsCipherUpperLetters(16);
  var c = cip.encrypt(s, replaceUnsupportedChar: true);
  print("Cipher: \n_________________________________");
  print(c);
  //print("Decrypt: \n_________________________________");
  //print(cip.decrypt(c));
  print("Crack: \n_________________________________");
  print(LetterFreqAnalysis.interactiveCrack(c));
  //print("Unicode ciphertext: \n_________________________________");
  //print(SubsCipherUnicode(16).encrypt(s));
}