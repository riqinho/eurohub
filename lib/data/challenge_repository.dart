import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/challenge.dart';

class ChallengeRepository {
  static const _assetPath = 'assets/mock/challenge_card_data.json';

  static Future<List<Challenge>> loadFromAssets() async {
    final jsonStr = await rootBundle.loadString(_assetPath);
    final List data = json.decode(jsonStr) as List;
    return data
        .map((e) => Challenge.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
