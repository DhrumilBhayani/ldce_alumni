import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'result.dart';
import 'package:http/http.dart' as http;

import 'package:ldce_alumni/core/globals.dart' as globals;

class Branch {
  final bool Status;
  final String Message;
  final List<ReqResult> Result;
  Branch({
    required this.Status,
    required this.Message,
    required this.Result,
  });

  Branch copyWith({
    bool? Status,
    String? Message,
    List<ReqResult>? Result,
  }) {
    return Branch(
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

  factory Branch.fromMap(Map<String, dynamic> map) {
    return Branch(
      Status: map['Status'] ?? false,
      Message: map['Message'] ?? '',
      Result: List<ReqResult>.from(map['Result']?.map((x) => ReqResult.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Branch.fromJson(String source) => Branch.fromMap(json.decode(source));

  @override
  String toString() => 'Branch(Status: $Status, Message: $Message, Result: $Result)';

  static Future<String> getBranchDetails() async {
    final http.Response response = await http.get(Uri.parse('${globals.BASE_API_URL}/Branch'));
    if (response.statusCode.toString() == "200") {
      var branchResponse = Branch.fromJson(response.body);
      print("branchResponse: $branchResponse");
      return response.body;
    } else {
      throw Exception('Failed to load Program data');
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Branch &&
      other.Status == Status &&
      other.Message == Message &&
      listEquals(other.Result, Result);
  }

  @override
  int get hashCode => Status.hashCode ^ Message.hashCode ^ Result.hashCode;
}