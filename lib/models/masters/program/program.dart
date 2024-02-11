import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:ldce_alumni/core/globals.dart' as globals;
import 'result.dart';

class Program {
  final bool Status;
  final String Message;
  final List<ReqResult> Result;
  Program({
    required this.Status,
    required this.Message,
    required this.Result,
  });

  Program copyWith({
    bool? Status,
    String? Message,
    List<ReqResult>? Result,
  }) {
    return Program(
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

  factory Program.fromMap(Map<String, dynamic> map) {
    return Program(
      Status: map['Status'] ?? false,
      Message: map['Message'] ?? '',
      Result: List<ReqResult>.from(map['Result']?.map((x) => ReqResult.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Program.fromJson(String source) => Program.fromMap(json.decode(source));

  @override
  String toString() => 'Program(Status: $Status, Message: $Message, Result: $Result)';

  static Future<String> getProgramDetails() async {
    final http.Response response = await http.get(Uri.parse('${globals.BASE_API_URL}/Program'));
    if (response.statusCode.toString() == "200") {
      var programResponse = Program.fromJson(response.body);
      print("programResponse: ${programResponse}");
      return response.body;
    } else {
      throw Exception('Failed to load Program data');
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Program && other.Status == Status && other.Message == Message && listEquals(other.Result, Result);
  }

  @override
  int get hashCode => Status.hashCode ^ Message.hashCode ^ Result.hashCode;
}
