import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/chapter.dart';

class ConstitutionRepository {
  static Future<List<Chapter>> loadConstitution() async {
    try {
      final String jsonString =
          await rootBundle.loadString('lib/data/constitution.json');
      final List<dynamic> jsonData = json.decode(jsonString);
      return jsonData
          .map((chapter) => Chapter.fromJson(chapter as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load constitution: $e');
    }
  }
}

