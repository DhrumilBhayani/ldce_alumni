import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ldce_alumni/core/globals.dart' as globals;

class UpdateMembershipType {
  final bool Status;
  final String Message;
  final String Result;
  UpdateMembershipType({
    required this.Status,
    required this.Message,
    required this.Result,
  });

  UpdateMembershipType copyWith({
    bool? Status,
    String? Message,
    String? Result,
  }) {
    return UpdateMembershipType(
      Status: Status ?? this.Status,
      Message: Message ?? this.Message,
      Result: Result ?? this.Result,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'Status': Status});
    result.addAll({'Message': Message});
    result.addAll({'Result': Result});

    return result;
  }

  factory UpdateMembershipType.fromMap(Map<String, dynamic> map) {
    return UpdateMembershipType(
      Status: map['Status'] ?? false,
      Message: map['Message'] ?? '',
      Result: map['Result'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  static Future<UpdateMembershipType> updateMembershipTypeDetails({required encId, required membershipId}) async {
    var encId = await globals.FlutterSecureStorageObj.read(key: "encId");

    final http.Response response = await http.put(
      Uri.parse('${globals.BASE_API_URL}/Alumni/ChangeMembershipRequest/$encId/$membershipId'),
      // headers: <String, String>{'Accept': '*/*'}
    );
    log('updateMembershipTypeDetails ${response.body}');

    var updateMembershipResponse = UpdateMembershipType.fromJson(response.body);
    // log(profileResponse.Result.FirstName);

    return updateMembershipResponse;
  }

  factory UpdateMembershipType.fromJson(String source) => UpdateMembershipType.fromMap(json.decode(source));

  @override
  String toString() => 'UpdateMembershipType(Status: $Status, Message: $Message, Result: $Result)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UpdateMembershipType && other.Status == Status && other.Message == Message && other.Result == Result;
  }

  @override
  int get hashCode => Status.hashCode ^ Message.hashCode ^ Result.hashCode;
}
