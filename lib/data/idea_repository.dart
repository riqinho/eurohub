import 'dart:convert';
import 'package:eurohub/models/ideia.dart';
import 'package:flutter/services.dart' show rootBundle;

class IdeaRepository {
  static const _assetPath = 'assets/mock/ideias_card_data.json'; // <- aqui

  static Future<List<Idea>> loadFromAssets() async {
    final jsonStr = await rootBundle.loadString(_assetPath);
    final List data = json.decode(jsonStr) as List;
    return data.map((e) => Idea.fromJson(e as Map<String, dynamic>)).toList();
  }
}
