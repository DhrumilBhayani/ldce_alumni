import 'dart:convert';
import 'dart:math';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ldce_alumni/core/globals.dart' as globals;

// import 'package:ldce_alumni/models/profile/profile.dart';

class Country {
  final bool Status;
  final String Message;
  //final List<Result>? Result
  final ReqResult Result;
  Country({
    required this.Status,
    required this.Message,
    required this.Result,
  });

  Country copyWith({
    bool? Status,
    String? Message,
    // List<Result>? Result,
    ReqResult? Result,
  }) {
    return Country(
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

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      Status: map['Status'] ?? false,
      Message: map['Message'] ?? '',
      // Result: List<Result>.from(map['Result']?.map((x) => Result.fromMap(x))),
      Result: ReqResult.fromMap(map['Result']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source));

  @override
  String toString() =>
      'Country(Status: $Status, Message: $Message, Result: $Result)';

  static Future<Country> getCountryDetails() async {
    final http.Response response =
        await http.get(Uri.parse('${globals.BASE_API_URL}/Country'));
    print("countryResponse- ${response.body}");
    if (response.statusCode == "200") {
      var countryResponse = Country.fromJson(response.body);
      print("countryResponse: ${countryResponse.Status}");
      return countryResponse;
    } else {
      throw Exception('Failed to load Country data');
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    // final listEquals = const DeepCollectionEquality().equals;

    return other is Country &&
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
  final bool IsActive;
  final bool IsDeleted;
  final String CreatedOn;
  final int CreatedBy;
  // final ModifiedOn ModifiedOn;
  // final ModifiedBy ModifiedBy;
  final String CountryCode;
  ReqResult({
    required this.Id,
    required this.Name,
    required this.IsActive,
    required this.IsDeleted,
    required this.CreatedOn,
    required this.CreatedBy,
    // required this.ModifiedOn,
    // required this.ModifiedBy,
    required this.CountryCode,
  });

  ReqResult copyWith({
    int? Id,
    String? Name,
    bool? IsActive,
    bool? IsDeleted,
    String? CreatedOn,
    int? CreatedBy,
    // ModifiedOn? ModifiedOn,
    // ModifiedBy? ModifiedBy,
    String? CountryCode,
  }) {
    return ReqResult(
      Id: Id ?? this.Id,
      Name: Name ?? this.Name,
      IsActive: IsActive ?? this.IsActive,
      IsDeleted: IsDeleted ?? this.IsDeleted,
      CreatedOn: CreatedOn ?? this.CreatedOn,
      CreatedBy: CreatedBy ?? this.CreatedBy,
      // ModifiedOn: ModifiedOn ?? this.ModifiedOn,
      // ModifiedBy: ModifiedBy ?? this.ModifiedBy,
      CountryCode: CountryCode ?? this.CountryCode,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'Id': Id});
    result.addAll({'Name': Name});
    result.addAll({'IsActive': IsActive});
    result.addAll({'IsDeleted': IsDeleted});
    result.addAll({'CreatedOn': CreatedOn});
    result.addAll({'CreatedBy': CreatedBy});
    // result.addAll({'ModifiedOn': ModifiedOn.toMap()});
    // result.addAll({'ModifiedBy': ModifiedBy.toMap()});
    result.addAll({'CountryCode': CountryCode});

    return result;
  }

  factory ReqResult.fromMap(Map<String, dynamic> map) {
    return ReqResult(
      Id: map['Id']?.toInt() ?? 0,
      Name: map['Name'] ?? '',
      IsActive: map['IsActive'] ?? false,
      IsDeleted: map['IsDeleted'] ?? false,
      CreatedOn: map['CreatedOn'] ?? '',
      CreatedBy: map['CreatedBy']?.toInt() ?? 0,
      // ModifiedOn: ModifiedOn.fromMap(map['ModifiedOn']),
      // ModifiedBy: ModifiedBy.fromMap(map['ModifiedBy']),
      CountryCode: map['CountryCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ReqResult.fromJson(String source) =>
      ReqResult.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Result(Id: $Id, Name: $Name, IsActive: $IsActive, IsDeleted: $IsDeleted, CreatedOn: $CreatedOn, CreatedBy: $CreatedBy,  CountryCode: $CountryCode)';
    // ModifiedOn: $ModifiedOn, ModifiedBy: $ModifiedBy,
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReqResult &&
        other.Id == Id &&
        other.Name == Name &&
        other.IsActive == IsActive &&
        other.IsDeleted == IsDeleted &&
        other.CreatedOn == CreatedOn &&
        other.CreatedBy == CreatedBy &&
        // other.ModifiedOn == ModifiedOn &&
        // other.ModifiedBy == ModifiedBy &&
        other.CountryCode == CountryCode;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        Name.hashCode ^
        IsActive.hashCode ^
        IsDeleted.hashCode ^
        CreatedOn.hashCode ^
        CreatedBy.hashCode ^
        // ModifiedOn.hashCode ^
        // ModifiedBy.hashCode ^
        CountryCode.hashCode;
  }
}

// class ModifiedOn {
// }

// class ModifiedBy {
// }