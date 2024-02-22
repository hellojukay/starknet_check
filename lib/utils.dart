import 'dart:convert';

import 'package:flutter/services.dart';

Future<String?> getAmount(String identity) async {
  String github = identity.trim();
  String? amount = await checkJson("assets/github-0.json", github);
  if (amount != null && amount.isNotEmpty) {
    return amount;
  }
  return await checkJson("assets/github-1.json", github);
}

Future<String?> checkJson(String file, String github) async {
  String data = await rootBundle.loadString(file);
  final jsonResult = jsonDecode(data); //latest Dart
  List<dynamic> eligibles = jsonResult['eligibles'] as List<dynamic>;
  for (var eligible in eligibles) {
    String? name = eligible['identity'];
    if (name == null) {
      continue;
    }
    if (name == github) {
      return eligible['amount'];
    }
  }
  return null;
}
