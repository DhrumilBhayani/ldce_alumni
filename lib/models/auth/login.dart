import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ldce_alumni/core/globals.dart' as globals;

class Auth {
  final String access_token;
  final String token_type;
  final int expires_in;
  Auth({
    required this.access_token,
    required this.token_type,
    required this.expires_in,
  });

  Auth copyWith({
    String? access_token,
    String? token_type,
    int? expires_in,
  }) {
    return Auth(
      access_token: access_token ?? this.access_token,
      token_type: token_type ?? this.token_type,
      expires_in: expires_in ?? this.expires_in,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'access_token': access_token});
    result.addAll({'token_type': token_type});
    result.addAll({'expires_in': expires_in});

    return result;
  }

  factory Auth.fromMap(Map<String, dynamic> map) {
    return Auth(
      access_token: map['access_token'] ?? '',
      token_type: map['token_type'] ?? '',
      expires_in: map['expires_in']?.toInt() ?? 0,
    );
  }

  static Future<Auth> doLogin({required String email, required String password}) async {
    log(email);
    log(password);
    final http.Response response =
        await http.post(Uri.parse('${globals.BASE_API_URL}/Login'), headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': '*/*'
    }, body: {
      'grant_type': 'password',
      'username': email,
      'password': password,
      'remember': 'true',
    });
    log(response.body);

    var loginResponse = Auth.fromJson(response.body);
    log(loginResponse.access_token);

    return loginResponse;
  }

  static Future getEncId() async {
    var token = await globals.FlutterSecureStorageObj.read(key: "access_token");
    final http.Response response = await http.get(
      Uri.parse('${globals.BASE_API_URL}/Alumni/GetId'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': '*/*',
        "Authorization": "Bearer $token"
      },
    );
    log(response.body);

    var encIdResponse = jsonDecode(response.body);
    log(encIdResponse["Result"]);
    await globals.FlutterSecureStorageObj.write(
      key: "encId",
      value: encIdResponse["Result"],
    );
    return encIdResponse;
  }

  String toJson() => json.encode(toMap());

  factory Auth.fromJson(String source) => Auth.fromMap(json.decode(source));

  @override
  String toString() =>
      'Auth(access_token: $access_token, token_type: $token_type, expires_in: $expires_in)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Auth &&
        other.access_token == access_token &&
        other.token_type == token_type &&
        other.expires_in == expires_in;
  }

  @override
  int get hashCode => access_token.hashCode ^ token_type.hashCode ^ expires_in.hashCode;
}
