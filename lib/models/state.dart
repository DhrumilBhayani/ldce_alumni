import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ldce_alumni/core/globals.dart' as globals;

class State {
  final bool Status;
  final String Message;
  // final List<Result> Result;
  final ReqResult Result;
  State({
    required this.Status,
    required this.Message,
    required this.Result,
  });

  State copyWith({
    bool? Status,
    String? Message,
    // List<Result>? Result,
    ReqResult? Result,
  }) {
    return State(
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

  factory State.fromMap(Map<String, dynamic> map) {
    return State(
      Status: map['Status'] ?? false,
      Message: map['Message'] ?? '',
      // Result: List<Result>.from(map['Result']?.map((x) => Result.fromMap(x))),
      Result: ReqResult.fromMap(map['Result']),
    );
  }

  String toJson() => json.encode(toMap());

  factory State.fromJson(String source) => State.fromMap(json.decode(source));

  @override
  String toString() =>
      'State(Status: $Status, Message: $Message, Result: $Result)';

  static Future<State> getStateDetails() async {
    final http.Response response =
        await http.get(Uri.parse('${globals.BASE_API_URL}/State'));

    if (response.statusCode == 200) {
      // final List<dynamic> data = Profile.fromJson(response.body);
      var countryResponse = State.fromJson(response.body);
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

    return other is State &&
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
  final int CountryId;
  final bool IsActive;
  final bool IsDeleted;
  final String CreatedOn;
  final int CreatedBy;
  ReqResult({
    required this.Id,
    required this.Name,
    required this.CountryId,
    required this.IsActive,
    required this.IsDeleted,
    required this.CreatedOn,
    required this.CreatedBy,
  });

  ReqResult copyWith({
    int? Id,
    String? Name,
    int? CountryId,
    bool? IsActive,
    bool? IsDeleted,
    String? CreatedOn,
    int? CreatedBy,
  }) {
    return ReqResult(
      Id: Id ?? this.Id,
      Name: Name ?? this.Name,
      CountryId: CountryId ?? this.CountryId,
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
    result.addAll({'CountryId': CountryId});
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
      CountryId: map['CountryId']?.toInt() ?? 0,
      IsActive: map['IsActive'] ?? false,
      IsDeleted: map['IsDeleted'] ?? false,
      CreatedOn: map['CreatedOn'] ?? '',
      CreatedBy: map['CreatedBy']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReqResult.fromJson(String source) =>
      ReqResult.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Result(Id: $Id, Name: $Name, CountryId: $CountryId, IsActive: $IsActive, IsDeleted: $IsDeleted, CreatedOn: $CreatedOn, CreatedBy: $CreatedBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReqResult &&
        other.Id == Id &&
        other.Name == Name &&
        other.CountryId == CountryId &&
        other.IsActive == IsActive &&
        other.IsDeleted == IsDeleted &&
        other.CreatedOn == CreatedOn &&
        other.CreatedBy == CreatedBy;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        Name.hashCode ^
        CountryId.hashCode ^
        IsActive.hashCode ^
        IsDeleted.hashCode ^
        CreatedOn.hashCode ^
        CreatedBy.hashCode;
  }
}
