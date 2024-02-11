import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ldce_alumni/core/globals.dart' as globals;

// import 'package:ldce_alumni/models/country.dart';

class City {
  final bool Status;
  final String Message;
  // final List<Result> Result;
  final ReqResult Result;
  City({
    required this.Status,
    required this.Message,
    required this.Result,
  });

  City copyWith({
    bool? Status,
    String? Message,
    // List<Result>? Result,
    ReqResult? Result,
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
    // result.addAll({'Result': Result.map((x) => x.toMap()).toList()});
    result.addAll({'Result': Result.toMap()});
  
    return result;
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      Status: map['Status'] ?? false,
      Message: map['Message'] ?? '',
      // Result: List<Result>.from(map['Result']?.map((x) => Result.fromMap(x))),
      Result: ReqResult.fromMap(map['Result']),
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) => City.fromMap(json.decode(source));

  @override
  String toString() => 'City(Status: $Status, Message: $Message, Result: $Result)';

  static Future<City> getCityDetails() async {
    final http.Response response = await http
        .get(Uri.parse('${globals.BASE_API_URL}/City'));

    if (response.statusCode == 200) {
      // final List<dynamic> data = Profile.fromJson(response.body);
      var countryResponse = City.fromJson(response.body);
      // return List<String>.from(data);
      return countryResponse;
    } else {
      throw Exception('Failed to load Country data');
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    // final listEquals = const DeepCollectionEquality().equals;
  
    return other is City &&
      other.Status == Status &&
      other.Message == Message &&
      other.Result == Result;
      // listEquals(other.Result, Result);
  }

  @override
  int get hashCode => Status.hashCode ^ Message.hashCode ^ Result.hashCode;
}

class ReqResult {
  final int Id;
  final String Name;
  final int StateId;
  final bool IsActive;
  final bool IsDeleted;
  final String CreatedOn;
  final int CreatedBy;
  ReqResult({
    required this.Id,
    required this.Name,
    required this.StateId,
    required this.IsActive,
    required this.IsDeleted,
    required this.CreatedOn,
    required this.CreatedBy,
  });

  ReqResult copyWith({
    int? Id,
    String? Name,
    int? StateId,
    bool? IsActive,
    bool? IsDeleted,
    String? CreatedOn,
    int? CreatedBy,
  }) {
    return ReqResult(
      Id: Id ?? this.Id,
      Name: Name ?? this.Name,
      StateId: StateId ?? this.StateId,
      IsActive: IsActive ?? this.IsActive,
      IsDeleted: IsDeleted ?? this.IsDeleted,
      CreatedOn: CreatedOn ?? this.CreatedOn,
      CreatedBy: CreatedBy ?? this.CreatedBy,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'Id': Id});
    result.addAll({'Name': Name});
    result.addAll({'StateId': StateId});
    result.addAll({'IsActive': IsActive});
    result.addAll({'IsDeleted': IsDeleted});
    result.addAll({'CreatedOn': CreatedOn});
    result.addAll({'CreatedBy': CreatedBy});
  
    return result;
  }

  factory ReqResult.fromMap(Map<String, dynamic> map) {
    return ReqResult(
      Id: map['Id']?.toInt() ?? 0,
      Name: map['Name'] ?? '',
      StateId: map['StateId']?.toInt() ?? 0,
      IsActive: map['IsActive'] ?? false,
      IsDeleted: map['IsDeleted'] ?? false,
      CreatedOn: map['CreatedOn'] ?? '',
      CreatedBy: map['CreatedBy']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReqResult.fromJson(String source) => ReqResult.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Result(Id: $Id, Name: $Name, StateId: $StateId, IsActive: $IsActive, IsDeleted: $IsDeleted, CreatedOn: $CreatedOn, CreatedBy: $CreatedBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ReqResult &&
      other.Id == Id &&
      other.Name == Name &&
      other.StateId == StateId &&
      other.IsActive == IsActive &&
      other.IsDeleted == IsDeleted &&
      other.CreatedOn == CreatedOn &&
      other.CreatedBy == CreatedBy;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
      Name.hashCode ^
      StateId.hashCode ^
      IsActive.hashCode ^
      IsDeleted.hashCode ^
      CreatedOn.hashCode ^
      CreatedBy.hashCode;
  }
}