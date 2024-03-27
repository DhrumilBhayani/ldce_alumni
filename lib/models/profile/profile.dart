import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ldce_alumni/core/globals.dart' as globals;

class Profile {
  final bool Status;
  final String Message;
  final ReqResult Result;
  Profile({
    required this.Status,
    required this.Message,
    required this.Result,
  });

  Profile copyWith({
    bool? Status,
    String? Message,
    ReqResult? Result,
  }) {
    return Profile(
      Status: Status ?? this.Status,
      Message: Message ?? this.Message,
      Result: Result ?? this.Result,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'Status': Status});
    result.addAll({'Message': Message});
    result.addAll({'Result': Result.toMap()});
  
    return result;
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      Status: map['Status'] ?? false,
      Message: map['Message'] ?? '',
      Result: ReqResult.fromMap(map['Result']),
    );
  }

  static Future<Profile> getProfileDetails({required encId}) async {
    var encId = await globals.FlutterSecureStorageObj.read(key: "encId");

    final http.Response response = await http.get(
        Uri.parse('${globals.BASE_API_URL}/alumni?EncryptedId=$encId'),
        headers: <String, String>{'Accept': '*/*'});
    log(response.body);

    var profileResponse = Profile.fromJson(response.body);
    log(profileResponse.Result.FirstName);

    return profileResponse;
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) => Profile.fromMap(json.decode(source));

  @override
  String toString() => 'Profile(Status: $Status, Message: $Message, Result: $Result)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Profile &&
      other.Status == Status &&
      other.Message == Message &&
      other.Result == Result;
  }

  @override
  int get hashCode => Status.hashCode ^ Message.hashCode ^ Result.hashCode;
}

class ReqResult {
  final String EncryptedId;
  final String FirstName;
  final String MiddleName;
  final String LastName;
  final String FullName;
  final bool Gender;
  final String DOB;
  final int CountryId;
  final int StateId;
  final int CityId;
  final String CountryName;
  final String StateName;
  final String CityName;
  final String ProfilePicPath;
  final String PrimaryAddress;
  final String SecondaryAddress;
  final String EmailAddress;
  final String PinCode;
  final String MobileNo;
  final String TelephoneNo;
  final String CompanyName;
  final String CompanyAddress;
  final String Designation;
  final String PassoutYear;
  final int StreamId;
  final int DegreeId;
  final String StreamName;
  final String DegreeName;
  final int MembershipTypeId;
  final String Membership;
  final bool IsMembershipVerified;
  final bool IsEligibleForChangeMembership;
  final bool IsChangeMembershipRequestSent;
  final String RequestStatus;
  ReqResult({
    required this.EncryptedId,
    required this.FirstName,
    required this.MiddleName,
    required this.LastName,
    required this.FullName,
    required this.Gender,
    required this.DOB,
    required this.CountryId,
    required this.StateId,
    required this.CityId,
    required this.CountryName,
    required this.StateName,
    required this.CityName,
    required this.ProfilePicPath,
    required this.PrimaryAddress,
    required this.SecondaryAddress,
    required this.EmailAddress,
    required this.PinCode,
    required this.MobileNo,
    required this.TelephoneNo,
    required this.CompanyName,
    required this.CompanyAddress,
    required this.Designation,
    required this.PassoutYear,
    required this.StreamId,
    required this.DegreeId,
    required this.StreamName,
    required this.DegreeName,
    required this.MembershipTypeId,
    required this.Membership,
    required this.IsMembershipVerified,
    required this.IsEligibleForChangeMembership,
    required this.IsChangeMembershipRequestSent,
    required this.RequestStatus,
  });

  ReqResult copyWith({
    String? EncryptedId,
    String? FirstName,
    String? MiddleName,
    String? LastName,
    String? FullName,
    bool? Gender,
    String? DOB,
    int? CountryId,
    int? StateId,
    int? CityId,
    String? CountryName,
    String? StateName,
    String? CityName,
    String? ProfilePicPath,
    String? PrimaryAddress,
    String? SecondaryAddress,
    String? EmailAddress,
    String? PinCode,
    String? MobileNo,
    String? TelephoneNo,
    String? CompanyName,
    String? CompanyAddress,
    String? Designation,
    String? PassoutYear,
    int? StreamId,
    int? DegreeId,
    String? StreamName,
    String? DegreeName,
    int? MembershipTypeId,
    String? Membership,
    bool? IsMembershipVerified,
    bool? IsEligibleForChangeMembership,
    bool? IsChangeMembershipRequestSent,
    String? RequestStatus,
  }) {
    return ReqResult(
      EncryptedId: EncryptedId ?? this.EncryptedId,
      FirstName: FirstName ?? this.FirstName,
      MiddleName: MiddleName ?? this.MiddleName,
      LastName: LastName ?? this.LastName,
      FullName: FullName ?? this.FullName,
      Gender: Gender ?? this.Gender,
      DOB: DOB ?? this.DOB,
      CountryId: CountryId ?? this.CountryId,
      StateId: StateId ?? this.StateId,
      CityId: CityId ?? this.CityId,
      CountryName: CountryName ?? this.CountryName,
      StateName: StateName ?? this.StateName,
      CityName: CityName ?? this.CityName,
      ProfilePicPath: ProfilePicPath ?? this.ProfilePicPath,
      PrimaryAddress: PrimaryAddress ?? this.PrimaryAddress,
      SecondaryAddress: SecondaryAddress ?? this.SecondaryAddress,
      EmailAddress: EmailAddress ?? this.EmailAddress,
      PinCode: PinCode ?? this.PinCode,
      MobileNo: MobileNo ?? this.MobileNo,
      TelephoneNo: TelephoneNo ?? this.TelephoneNo,
      CompanyName: CompanyName ?? this.CompanyName,
      CompanyAddress: CompanyAddress ?? this.CompanyAddress,
      Designation: Designation ?? this.Designation,
      PassoutYear: PassoutYear ?? this.PassoutYear,
      StreamId: StreamId ?? this.StreamId,
      DegreeId: DegreeId ?? this.DegreeId,
      StreamName: StreamName ?? this.StreamName,
      DegreeName: DegreeName ?? this.DegreeName,
      MembershipTypeId: MembershipTypeId ?? this.MembershipTypeId,
      Membership: Membership ?? this.Membership,
      IsMembershipVerified: IsMembershipVerified ?? this.IsMembershipVerified,
      IsEligibleForChangeMembership: IsEligibleForChangeMembership ?? this.IsEligibleForChangeMembership,
      IsChangeMembershipRequestSent: IsChangeMembershipRequestSent ?? this.IsChangeMembershipRequestSent,
      RequestStatus: RequestStatus ?? this.RequestStatus,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'EncryptedId': EncryptedId});
    result.addAll({'FirstName': FirstName});
    result.addAll({'MiddleName': MiddleName});
    result.addAll({'LastName': LastName});
    result.addAll({'FullName': FullName});
    result.addAll({'Gender': Gender});
    result.addAll({'DOB': DOB});
    result.addAll({'CountryId': CountryId});
    result.addAll({'StateId': StateId});
    result.addAll({'CityId': CityId});
    result.addAll({'CountryName': CountryName});
    result.addAll({'StateName': StateName});
    result.addAll({'CityName': CityName});
    result.addAll({'ProfilePicPath': ProfilePicPath});
    result.addAll({'PrimaryAddress': PrimaryAddress});
    result.addAll({'SecondaryAddress': SecondaryAddress});
    result.addAll({'EmailAddress': EmailAddress});
    result.addAll({'PinCode': PinCode});
    result.addAll({'MobileNo': MobileNo});
    result.addAll({'TelephoneNo': TelephoneNo});
    result.addAll({'CompanyName': CompanyName});
    result.addAll({'CompanyAddress': CompanyAddress});
    result.addAll({'Designation': Designation});
    result.addAll({'PassoutYear': PassoutYear});
    result.addAll({'StreamId': StreamId});
    result.addAll({'DegreeId': DegreeId});
    result.addAll({'StreamName': StreamName});
    result.addAll({'DegreeName': DegreeName});
    result.addAll({'MembershipTypeId': MembershipTypeId});
    result.addAll({'Membership': Membership});
    result.addAll({'IsMembershipVerified': IsMembershipVerified});
    result.addAll({'IsEligibleForChangeMembership': IsEligibleForChangeMembership});
    result.addAll({'IsChangeMembershipRequestSent': IsChangeMembershipRequestSent});
    result.addAll({'RequestStatus': RequestStatus});
  
    return result;
  }

  factory ReqResult.fromMap(Map<String, dynamic> map) {
    return ReqResult(
      EncryptedId: map['EncryptedId'] ?? '',
      FirstName: map['FirstName'] ?? '',
      MiddleName: map['MiddleName'] ?? '',
      LastName: map['LastName'] ?? '',
      FullName: map['FullName'] ?? '',
      Gender: map['Gender'] ?? false,
      DOB: map['DOB'] ?? '',
      CountryId: map['CountryId']?.toInt() ?? 0,
      StateId: map['StateId']?.toInt() ?? 0,
      CityId: map['CityId']?.toInt() ?? 0,
      CountryName: map['CountryName'] ?? '',
      StateName: map['StateName'] ?? '',
      CityName: map['CityName'] ?? '',
      ProfilePicPath: map['ProfilePicPath'] ?? '',
      PrimaryAddress: map['PrimaryAddress'] ?? '',
      SecondaryAddress: map['SecondaryAddress'] ?? '',
      EmailAddress: map['EmailAddress'] ?? '',
      PinCode: map['PinCode'] ?? '',
      MobileNo: map['MobileNo'] ?? '',
      TelephoneNo: map['TelephoneNo'] ?? '',
      CompanyName: map['CompanyName'] ?? '',
      CompanyAddress: map['CompanyAddress'] ?? '',
      Designation: map['Designation'] ?? '',
      PassoutYear: map['PassoutYear'] ?? '',
      StreamId: map['StreamId']?.toInt() ?? 0,
      DegreeId: map['DegreeId']?.toInt() ?? 0,
      StreamName: map['StreamName'] ?? '',
      DegreeName: map['DegreeName'] ?? '',
      MembershipTypeId: map['MembershipTypeId']?.toInt() ?? 0,
      Membership: map['Membership'] ?? '',
      IsMembershipVerified: map['IsMembershipVerified'] ?? false,
      IsEligibleForChangeMembership: map['IsEligibleForChangeMembership'] ?? false,
      IsChangeMembershipRequestSent: map['IsChangeMembershipRequestSent'] ?? false,
      RequestStatus: map['RequestStatus'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ReqResult.fromJson(String source) => ReqResult.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Result(EncryptedId: $EncryptedId, FirstName: $FirstName, MiddleName: $MiddleName, LastName: $LastName, FullName: $FullName, Gender: $Gender, DOB: $DOB, CountryId: $CountryId, StateId: $StateId, CityId: $CityId, CountryName: $CountryName, StateName: $StateName, CityName: $CityName, ProfilePicPath: $ProfilePicPath, PrimaryAddress: $PrimaryAddress, SecondaryAddress: $SecondaryAddress, EmailAddress: $EmailAddress, PinCode: $PinCode, MobileNo: $MobileNo, TelephoneNo: $TelephoneNo, CompanyName: $CompanyName, CompanyAddress: $CompanyAddress, Designation: $Designation, PassoutYear: $PassoutYear, StreamId: $StreamId, DegreeId: $DegreeId, StreamName: $StreamName, DegreeName: $DegreeName, MembershipTypeId: $MembershipTypeId, Membership: $Membership, IsMembershipVerified: $IsMembershipVerified, IsEligibleForChangeMembership: $IsEligibleForChangeMembership, IsChangeMembershipRequestSent: $IsChangeMembershipRequestSent, RequestStatus: $RequestStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ReqResult &&
      other.EncryptedId == EncryptedId &&
      other.FirstName == FirstName &&
      other.MiddleName == MiddleName &&
      other.LastName == LastName &&
      other.FullName == FullName &&
      other.Gender == Gender &&
      other.DOB == DOB &&
      other.CountryId == CountryId &&
      other.StateId == StateId &&
      other.CityId == CityId &&
      other.CountryName == CountryName &&
      other.StateName == StateName &&
      other.CityName == CityName &&
      other.ProfilePicPath == ProfilePicPath &&
      other.PrimaryAddress == PrimaryAddress &&
      other.SecondaryAddress == SecondaryAddress &&
      other.EmailAddress == EmailAddress &&
      other.PinCode == PinCode &&
      other.MobileNo == MobileNo &&
      other.TelephoneNo == TelephoneNo &&
      other.CompanyName == CompanyName &&
      other.CompanyAddress == CompanyAddress &&
      other.Designation == Designation &&
      other.PassoutYear == PassoutYear &&
      other.StreamId == StreamId &&
      other.DegreeId == DegreeId &&
      other.StreamName == StreamName &&
      other.DegreeName == DegreeName &&
      other.MembershipTypeId == MembershipTypeId &&
      other.Membership == Membership &&
      other.IsMembershipVerified == IsMembershipVerified &&
      other.IsEligibleForChangeMembership == IsEligibleForChangeMembership &&
      other.IsChangeMembershipRequestSent == IsChangeMembershipRequestSent &&
      other.RequestStatus == RequestStatus;
  }

  @override
  int get hashCode {
    return EncryptedId.hashCode ^
      FirstName.hashCode ^
      MiddleName.hashCode ^
      LastName.hashCode ^
      FullName.hashCode ^
      Gender.hashCode ^
      DOB.hashCode ^
      CountryId.hashCode ^
      StateId.hashCode ^
      CityId.hashCode ^
      CountryName.hashCode ^
      StateName.hashCode ^
      CityName.hashCode ^
      ProfilePicPath.hashCode ^
      PrimaryAddress.hashCode ^
      SecondaryAddress.hashCode ^
      EmailAddress.hashCode ^
      PinCode.hashCode ^
      MobileNo.hashCode ^
      TelephoneNo.hashCode ^
      CompanyName.hashCode ^
      CompanyAddress.hashCode ^
      Designation.hashCode ^
      PassoutYear.hashCode ^
      StreamId.hashCode ^
      DegreeId.hashCode ^
      StreamName.hashCode ^
      DegreeName.hashCode ^
      MembershipTypeId.hashCode ^
      Membership.hashCode ^
      IsMembershipVerified.hashCode ^
      IsEligibleForChangeMembership.hashCode ^
      IsChangeMembershipRequestSent.hashCode ^
      RequestStatus.hashCode;
  }
}