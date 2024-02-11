import 'dart:convert';

class ReqResult {
  final int Id;
  final String Name;
  final int StateId;
  final bool IsActive;
  final bool IsDeleted;
  final String CreatedOn;
  final int CreatedBy;
  final String ModifiedOn;
  final String ModifiedBy;
  ReqResult({
    required this.Id,
    required this.Name,
    required this.StateId,
    required this.IsActive,
    required this.IsDeleted,
    required this.CreatedOn,
    required this.CreatedBy,
    required this.ModifiedOn,
    required this.ModifiedBy,
  });

  ReqResult copyWith({
    int? Id,
    String? Name,
    int? StateId,
    bool? IsActive,
    bool? IsDeleted,
    String? CreatedOn,
    int? CreatedBy,
    String? ModifiedOn,
    String? ModifiedBy,
  }) {
    return ReqResult(
      Id: Id ?? this.Id,
      Name: Name ?? this.Name,
      StateId: StateId ?? this.StateId,
      IsActive: IsActive ?? this.IsActive,
      IsDeleted: IsDeleted ?? this.IsDeleted,
      CreatedOn: CreatedOn ?? this.CreatedOn,
      CreatedBy: CreatedBy ?? this.CreatedBy,
      ModifiedOn: ModifiedOn ?? this.ModifiedOn,
      ModifiedBy: ModifiedBy ?? this.ModifiedBy,
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
    result.addAll({'ModifiedOn': ModifiedOn});
    result.addAll({'ModifiedBy': ModifiedBy});
  
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
      ModifiedOn: map['ModifiedOn'] ?? '',
      ModifiedBy: map['ModifiedBy'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ReqResult.fromJson(String source) => ReqResult.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Result(Id: $Id, Name: $Name, StateId: $StateId, IsActive: $IsActive, IsDeleted: $IsDeleted, CreatedOn: $CreatedOn, CreatedBy: $CreatedBy, ModifiedOn: $ModifiedOn, ModifiedBy: $ModifiedBy)';
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
      other.CreatedBy == CreatedBy &&
      other.ModifiedOn == ModifiedOn &&
      other.ModifiedBy == ModifiedBy;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
      Name.hashCode ^
      StateId.hashCode ^
      IsActive.hashCode ^
      IsDeleted.hashCode ^
      CreatedOn.hashCode ^
      CreatedBy.hashCode ^
      ModifiedOn.hashCode ^
      ModifiedBy.hashCode;
  }
}