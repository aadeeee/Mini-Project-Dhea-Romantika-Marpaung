import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store_app/const/format.dart';
import 'package:store_app/models/ai_model.dart';

class RecomendationService {
  static Future<Data> getRecomendation() async {
    late Data gptData = Data(
        id: "",
        object: "",
        created: 0,
        model: "",
        choices: [],
        usage: Usage(completionTokens: 0, promptTokens: 0, totalTokens: 0));
    try {
      var url = Uri.parse("https://api.openai.com/v1/completions");
      Map<String, String> headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'Authorization': 'Bearer $apiKey'
      };

      String promtData =
          "Berikan rekomendasi nama produk yang di pakai sehari-hari yang banyak di cari saat ini";

      final data = jsonEncode({
        "model": "text-davinci-003",
        "prompt": promtData,
        "temperature": 0.4,
        "max_tokens": 64,
        "top_p": 1,
        "frequency_penalty": 0,
        "presence_penalty": 0
      });
      var response = await http.post(url, headers: headers, body: data);
      if (response.statusCode == 200) {
        gptData = dataFromJson(response.body);
      }
    } catch (e) {
      throw Exception('Request denied');
    }
    return gptData;
  }
}