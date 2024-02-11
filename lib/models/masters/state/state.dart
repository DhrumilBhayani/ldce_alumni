import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'result.dart';
import 'package:http/http.dart' as http;
import 'package:ldce_alumni/core/globals.dart' as globals;

class States {
  final bool Status;
  final String Message;
  final List<ReqResult> Result;
  States({
    required this.Status,
    required this.Message,
    required this.Result,
  });

  States copyWith({
    bool? Status,
    String? Message,
    List<ReqResult>? Result,
  }) {
    return States(
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

  factory States.fromMap(Map<String, dynamic> map) {
    return States(
      Status: map['Status'] ?? false,
      Message: map['Message'] ?? '',
      Result: List<ReqResult>.from(map['Result']?.map((x) => ReqResult.fromMap(x))),
    );
  }

  static Future<String> getStateDetails() async {
    final http.Response response =
        await http.get(Uri.parse('${globals.BASE_API_URL}/State'));

    if (response.statusCode.toString() == "200") {
      var stateResponse = States.fromJson(response.body);
      print("stateResponse: ${stateResponse}");
      return response.body;
    } else {
      throw Exception('Failed to load Country data');
    }
  }

  String toJson() => json.encode(toMap());

  factory States.fromJson(String source) => States.fromMap(json.decode(source));

  @override
  String toString() => 'State(Status: $Status, Message: $Message, Result: $Result)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is States &&
      other.Status == Status &&
      other.Message == Message &&
      listEquals(other.Result, Result);
  }

  @override
  int get hashCode => Status.hashCode ^ Message.hashCode ^ Result.hashCode;
}