import 'dart:convert';

class ReqResult {
  final int Id;
  final String Name;
  final String ExtraName;
  final int Fees;
  final int Sequence;
  ReqResult({
    required this.Id,
    required this.Name,
    required this.ExtraName,
    required this.Fees,
    required this.Sequence,
  });

  ReqResult copyWith({
    int? Id,
    String? Name,
    String? ExtraName,
    int? Fees,
    int? Sequence,
  }) {
    return ReqResult(
      Id: Id ?? this.Id,
      Name: Name ?? this.Name,
      ExtraName: ExtraName ?? this.ExtraName,
      Fees: Fees ?? this.Fees,
      Sequence: Sequence ?? this.Sequence,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'Id': Id});
    result.addAll({'Name': Name});
    result.addAll({'ExtraName': ExtraName});
    result.addAll({'Fees': Fees});
    result.addAll({'Sequence': Sequence});
  
    return result;
  }

  factory ReqResult.fromMap(Map<String, dynamic> map) {
    return ReqResult(
      Id: map['Id']?.toInt() ?? 0,
      Name: map['Name'] ?? '',
      ExtraName: map['ExtraName'] ?? '',
      Fees: map['Fees']?.toInt() ?? 0,
      Sequence: map['Sequence']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReqResult.fromJson(String source) => ReqResult.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Result(Id: $Id, Name: $Name, ExtraName: $ExtraName, Fees: $Fees, Sequence: $Sequence)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ReqResult &&
      other.Id == Id &&
      other.Name == Name &&
      other.ExtraName == ExtraName &&
      other.Fees == Fees &&
      other.Sequence == Sequence;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
      Name.hashCode ^
      ExtraName.hashCode ^
      Fees.hashCode ^
      Sequence.hashCode;
  }
}