import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ldce_alumni/core/globals.dart' as globals;
import 'package:flutter/foundation.dart';

import 'result.dart';

class MembershipTypes {
  final bool Status;
  final String Message;
  final List<ReqResult> Result;
  MembershipTypes({
    required this.Status,
    required this.Message,
    required this.Result,
  });

  MembershipTypes copyWith({
    bool? Status,
    String? Message,
    List<ReqResult>? Result,
  }) {
    return MembershipTypes(
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

  static Future<MembershipTypes> getMembershipTypeDetails() async {
    // var encId = await globals.FlutterSecureStorageObj.read(key: "encId");

    final http.Response response = await http.get(
      Uri.parse('${globals.BASE_API_URL}/MembershipType'),
    );
    log(response.body);

    var membershipTypeResponse = MembershipTypes.fromJson(response.body);
    // log(profileResponse.Result.FirstName);
    log('membershipTypeResponse ${membershipTypeResponse.Result}');

    return membershipTypeResponse;
  }

  factory MembershipTypes.fromMap(Map<String, dynamic> map) {
    return MembershipTypes(
      Status: map['Status'] ?? false,
      Message: map['Message'] ?? '',
      Result: List<ReqResult>.from(map['Result']?.map((x) => ReqResult.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MembershipTypes.fromJson(String source) => MembershipTypes.fromMap(json.decode(source));

  @override
  String toString() => 'MembershipTypes(Status: $Status, Message: $Message, Result: $Result)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MembershipTypes && other.Status == Status && other.Message == Message && listEquals(other.Result, Result);
  }

  @override
  int get hashCode => Status.hashCode ^ Message.hashCode ^ Result.hashCode;
}
