import 'dart:convert';

class ReqResult {
  final int Id;
  final String Name;
  final int DegreeId;
  final bool IsActive;
  final bool IsDeleted;
  final String CreatedOn;
  final int CreatedBy;
  final String ModifiedOn;
  final String ModifiedBy;
  final String DegreeList;
  final bool IsChecked;
  ReqResult({
    required this.Id,
    required this.Name,
    required this.DegreeId,
    required this.IsActive,
    required this.IsDeleted,
    required this.CreatedOn,
    required this.CreatedBy,
    required this.ModifiedOn,
    required this.ModifiedBy,
    required this.DegreeList,
    required this.IsChecked,
  });

  ReqResult copyWith({
    int? Id,
    String? Name,
    int? DegreeId,
    bool? IsActive,
    bool? IsDeleted,
    String? CreatedOn,
    int? CreatedBy,
    String? ModifiedOn,
    String? ModifiedBy,
    String? DegreeList,
    bool? IsChecked,
  }) {
    return ReqResult(
      Id: Id ?? this.Id,
      Name: Name ?? this.Name,
      DegreeId: DegreeId ?? this.DegreeId,
      IsActive: IsActive ?? this.IsActive,
      IsDeleted: IsDeleted ?? this.IsDeleted,
      CreatedOn: CreatedOn ?? this.CreatedOn,
      CreatedBy: CreatedBy ?? this.CreatedBy,
      ModifiedOn: ModifiedOn ?? this.ModifiedOn,
      ModifiedBy: ModifiedBy ?? this.ModifiedBy,
      DegreeList: DegreeList ?? this.DegreeList,
      IsChecked: IsChecked ?? this.IsChecked,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'Id': Id});
    result.addAll({'Name': Name});
    result.addAll({'DegreeId': DegreeId});
    result.addAll({'IsActive': IsActive});
    result.addAll({'IsDeleted': IsDeleted});
    result.addAll({'CreatedOn': CreatedOn});
    result.addAll({'CreatedBy': CreatedBy});
    result.addAll({'ModifiedOn': ModifiedOn});
    result.addAll({'ModifiedBy': ModifiedBy});
    result.addAll({'DegreeList': DegreeList});
    result.addAll({'IsChecked': IsChecked});
  
    return result;
  }

  factory ReqResult.fromMap(Map<String, dynamic> map) {
    return ReqResult(
      Id: map['Id']?.toInt() ?? 0,
      Name: map['Name'] ?? '',
      DegreeId: map['DegreeId']?.toInt() ?? 0,
      IsActive: map['IsActive'] ?? false,
      IsDeleted: map['IsDeleted'] ?? false,
      CreatedOn: map['CreatedOn'] ?? '',
      CreatedBy: map['CreatedBy']?.toInt() ?? 0,
      ModifiedOn: map['ModifiedOn'] ?? '',
      ModifiedBy: map['ModifiedBy'] ?? '',
      DegreeList: map['DegreeList'] ?? '',
      IsChecked: map['IsChecked'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReqResult.fromJson(String source) => ReqResult.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Result(Id: $Id, Name: $Name, DegreeId: $DegreeId, IsActive: $IsActive, IsDeleted: $IsDeleted, CreatedOn: $CreatedOn, CreatedBy: $CreatedBy, ModifiedOn: $ModifiedOn, ModifiedBy: $ModifiedBy, DegreeList: $DegreeList, IsChecked: $IsChecked)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ReqResult &&
      other.Id == Id &&
      other.Name == Name &&
      other.DegreeId == DegreeId &&
      other.IsActive == IsActive &&
      other.IsDeleted == IsDeleted &&
      other.CreatedOn == CreatedOn &&
      other.CreatedBy == CreatedBy &&
      other.ModifiedOn == ModifiedOn &&
      other.ModifiedBy == ModifiedBy &&
      other.DegreeList == DegreeList &&
      other.IsChecked == IsChecked;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
      Name.hashCode ^
      DegreeId.hashCode ^
      IsActive.hashCode ^
      IsDeleted.hashCode ^
      CreatedOn.hashCode ^
      CreatedBy.hashCode ^
      ModifiedOn.hashCode ^
      ModifiedBy.hashCode ^
      DegreeList.hashCode ^
      IsChecked.hashCode;
  }
}