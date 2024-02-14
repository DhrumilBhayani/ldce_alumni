import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'result.dart';
import 'package:http/http.dart' as http;
import 'package:ldce_alumni/core/globals.dart' as globals;

class City {
  final bool Status;
  final String Message;
  final List<ReqResult> Result;
  City({
    required this.Status,
    required this.Message,
    required this.Result,
  });

  City copyWith({
    bool? Status,
    String? Message,
    List<ReqResult>? Result,
  }) {
    return City(
      Status: Status ?? this.Status,
      Message: Message ?? this.Message,
      Result: Result ?? this.Result,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'Status': Status});
    result.addAll({'Message': Message});
    result.addAll({'Result': Result.map((x) => x.toMap()).toList()});

    return result;
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      Status: map['Status'] ?? false,
      Message: map['Message'] ?? '',
      Result: List<ReqResult>.from(map['Result']?.map((x) => ReqResult.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) => City.fromMap(json.decode(source));

  @override
  String toString() => 'City(Status: $Status, Message: $Message, Result: $Result)';

  static Future<String> getCityDetails(int stateId) async {
    final http.Response response = await http.get(Uri.parse('${globals.BASE_API_URL}/City?StateId=$stateId'));
    // print("countryResponse- ${response.body}");
    log(response.statusCode.toString());
    if (response.statusCode.toString() == "200") {
      log("message");
      log(response.body);
      var cityResponse = City.fromJson(response.body);
      print("cityResponse: ${cityResponse}");
      return response.body;
    } else {
      throw Exception('Failed to load Country data');
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is City && other.Status == Status && other.Message == Message && listEquals(other.Result, Result);
  }

  @override
  int get hashCode => Status.hashCode ^ Message.hashCode ^ Result.hashCode;
}
