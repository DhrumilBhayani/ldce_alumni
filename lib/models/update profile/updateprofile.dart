import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ldce_alumni/core/globals.dart' as globals;

class UpdateProfile {
  final String EmailAddress;
  final String FirstName;
  final String MiddleName;
  final String LastName;
  final String FullName;
  final String Branch;
  final String Program;
  final String PassoutYear;
  final String CompanyName;
  final String Membership;
  final bool IsMembershipVerified;
  final bool HasMoreData;
  final bool Gender;
  final String DOB;
  final String PrimaryAddress;
  final String SecondaryAddress;
  final String PinCode;
  final String MobileNo;
  final String TelephoneNo;
  final String CompanyAddress;
  final String Designation;
  final bool IsRegistrationApproved;
  final int MembershipTypeId;
  final bool IsRejected;
  final String CountryName;
  final String StateName;
  final String CityName;
  final String ProfilePic;
  final String ProfilePicPath;
  final String LatestCertificate;
  final String LatestCertificatePath;
  final bool IsActive;
  final bool IsDeleted;
  final String CreatedOn;
  final int CreatedBy;
  final String ModifiedOn;
  final String ModifiedBy;
  UpdateProfile({
    required this.EmailAddress,
    required this.FirstName,
    required this.MiddleName,
    required this.LastName,
    required this.FullName,
    required this.Branch,
    required this.Program,
    required this.PassoutYear,
    required this.CompanyName,
    required this.Membership,
    required this.IsMembershipVerified,
    required this.HasMoreData,
    required this.Gender,
    required this.DOB,
    required this.PrimaryAddress,
    required this.SecondaryAddress,
    required this.PinCode,
    required this.MobileNo,
    required this.TelephoneNo,
    required this.CompanyAddress,
    required this.Designation,
    required this.IsRegistrationApproved,
    required this.MembershipTypeId,
    required this.IsRejected,
    required this.CountryName,
    required this.StateName,
    required this.CityName,
    required this.ProfilePic,
    required this.ProfilePicPath,
    required this.LatestCertificate,
    required this.LatestCertificatePath,
    required this.IsActive,
    required this.IsDeleted,
    required this.CreatedOn,
    required this.CreatedBy,
    required this.ModifiedOn,
    required this.ModifiedBy,
  });

  UpdateProfile copyWith({
    String? EmailAddress,
    String? FirstName,
    String? MiddleName,
    String? LastName,
    String? FullName,
    String? Branch,
    String? Program,
    String? PassoutYear,
    String? CompanyName,
    String? Membership,
    bool? IsMembershipVerified,
    bool? HasMoreData,
    bool? Gender,
    String? DOB,
    String? PrimaryAddress,
    String? SecondaryAddress,
    String? PinCode,
    String? MobileNo,
    String? TelephoneNo,
    String? CompanyAddress,
    String? Designation,
    bool? IsRegistrationApproved,
    int? MembershipTypeId,
    bool? IsRejected,
    String? CountryName,
    String? StateName,
    String? CityName,
    String? ProfilePic,
    String? ProfilePicPath,
    String? LatestCertificate,
    String? LatestCertificatePath,
    bool? IsActive,
    bool? IsDeleted,
    String? CreatedOn,
    int? CreatedBy,
    String? ModifiedOn,
    String? ModifiedBy,
  }) {
    return UpdateProfile(
      EmailAddress: EmailAddress ?? this.EmailAddress,
      FirstName: FirstName ?? this.FirstName,
      MiddleName: MiddleName ?? this.MiddleName,
      LastName: LastName ?? this.LastName,
      FullName: FullName ?? this.FullName,
      Branch: Branch ?? this.Branch,
      Program: Program ?? this.Program,
      PassoutYear: PassoutYear ?? this.PassoutYear,
      CompanyName: CompanyName ?? this.CompanyName,
      Membership: Membership ?? this.Membership,
      IsMembershipVerified: IsMembershipVerified ?? this.IsMembershipVerified,
      HasMoreData: HasMoreData ?? this.HasMoreData,
      Gender: Gender ?? this.Gender,
      DOB: DOB ?? this.DOB,
      PrimaryAddress: PrimaryAddress ?? this.PrimaryAddress,
      SecondaryAddress: SecondaryAddress ?? this.SecondaryAddress,
      PinCode: PinCode ?? this.PinCode,
      MobileNo: MobileNo ?? this.MobileNo,
      TelephoneNo: TelephoneNo ?? this.TelephoneNo,
      CompanyAddress: CompanyAddress ?? this.CompanyAddress,
      Designation: Designation ?? this.Designation,
      IsRegistrationApproved: IsRegistrationApproved ?? this.IsRegistrationApproved,
      MembershipTypeId: MembershipTypeId ?? this.MembershipTypeId,
      IsRejected: IsRejected ?? this.IsRejected,
      CountryName: CountryName ?? this.CountryName,
      StateName: StateName ?? this.StateName,
      CityName: CityName ?? this.CityName,
      ProfilePic: ProfilePic ?? this.ProfilePic,
      ProfilePicPath: ProfilePicPath ?? this.ProfilePicPath,
      LatestCertificate: LatestCertificate ?? this.LatestCertificate,
      LatestCertificatePath: LatestCertificatePath ?? this.LatestCertificatePath,
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

    result.addAll({'EmailAddress': EmailAddress});
    result.addAll({'FirstName': FirstName});
    result.addAll({'MiddleName': MiddleName});
    result.addAll({'LastName': LastName});
    result.addAll({'FullName': FullName});
    result.addAll({'Branch': Branch});
    result.addAll({'Program': Program});
    result.addAll({'PassoutYear': PassoutYear});
    result.addAll({'CompanyName': CompanyName});
    result.addAll({'Membership': Membership});
    result.addAll({'IsMembershipVerified': IsMembershipVerified});
    result.addAll({'HasMoreData': HasMoreData});
    result.addAll({'Gender': Gender});
    result.addAll({'DOB': DOB});
    result.addAll({'PrimaryAddress': PrimaryAddress});
    result.addAll({'SecondaryAddress': SecondaryAddress});
    result.addAll({'PinCode': PinCode});
    result.addAll({'MobileNo': MobileNo});
    result.addAll({'TelephoneNo': TelephoneNo});
    result.addAll({'CompanyAddress': CompanyAddress});
    result.addAll({'Designation': Designation});
    result.addAll({'IsRegistrationApproved': IsRegistrationApproved});
    result.addAll({'MembershipTypeId': MembershipTypeId});
    result.addAll({'IsRejected': IsRejected});
    result.addAll({'CountryName': CountryName});
    result.addAll({'StateName': StateName});
    result.addAll({'CityName': CityName});
    result.addAll({'ProfilePic': ProfilePic});
    result.addAll({'ProfilePicPath': ProfilePicPath});
    result.addAll({'LatestCertificate': LatestCertificate});
    result.addAll({'LatestCertificatePath': LatestCertificatePath});
    result.addAll({'IsActive': IsActive});
    result.addAll({'IsDeleted': IsDeleted});
    result.addAll({'CreatedOn': CreatedOn});
    result.addAll({'CreatedBy': CreatedBy});
    result.addAll({'ModifiedOn': ModifiedOn});
    result.addAll({'ModifiedBy': ModifiedBy});

    return result;
  }

  factory UpdateProfile.fromMap(Map<String, dynamic> map) {
    return UpdateProfile(
      EmailAddress: map['EmailAddress'] ?? '',
      FirstName: map['FirstName'] ?? '',
      MiddleName: map['MiddleName'] ?? '',
      LastName: map['LastName'] ?? '',
      FullName: map['FullName'] ?? '',
      Branch: map['Branch'] ?? '',
      Program: map['Program'] ?? '',
      PassoutYear: map['PassoutYear'] ?? '',
      CompanyName: map['CompanyName'] ?? '',
      Membership: map['Membership'] ?? '',
      IsMembershipVerified: map['IsMembershipVerified'] ?? false,
      HasMoreData: map['HasMoreData'] ?? false,
      Gender: map['Gender'] ?? false,
      DOB: map['DOB'] ?? '',
      PrimaryAddress: map['PrimaryAddress'] ?? '',
      SecondaryAddress: map['SecondaryAddress'] ?? '',
      PinCode: map['PinCode'] ?? '',
      MobileNo: map['MobileNo'] ?? '',
      TelephoneNo: map['TelephoneNo'] ?? '',
      CompanyAddress: map['CompanyAddress'] ?? '',
      Designation: map['Designation'] ?? '',
      IsRegistrationApproved: map['IsRegistrationApproved'] ?? false,
      MembershipTypeId: map['MembershipTypeId']?.toInt() ?? 0,
      IsRejected: map['IsRejected'] ?? false,
      CountryName: map['CountryName'] ?? '',
      StateName: map['StateName'] ?? '',
      CityName: map['CityName'] ?? '',
      ProfilePic: map['ProfilePic'] ?? '',
      ProfilePicPath: map['ProfilePicPath'] ?? '',
      LatestCertificate: map['LatestCertificate'] ?? '',
      LatestCertificatePath: map['LatestCertificatePath'] ?? '',
      IsActive: map['IsActive'] ?? false,
      IsDeleted: map['IsDeleted'] ?? false,
      CreatedOn: map['CreatedOn'] ?? '',
      CreatedBy: map['CreatedBy']?.toInt() ?? 0,
      ModifiedOn: map['ModifiedOn'] ?? '',
      ModifiedBy: map['ModifiedBy'] ?? '',
    );
  }

  static Future<UpdateProfile> updateProfileDetails({required encId, required token, required dataBody}) async {
    var encId = await globals.FlutterSecureStorageObj.read(key: "encId");
    var token = await globals.FlutterSecureStorageObj.read(key: "access_token");
    log('profileData: 111 $dataBody');
    var response = await http.post(Uri.parse(globals.BASE_API_URL + '/Alumni/Update?EncryptedId=$encId'),
        headers: <String, String>{"Authorization": "Bearer $token", "Content-type": "application/json"},
        body: jsonEncode(dataBody
            // {
            // 'PrimaryAddress': primaryAddTEC.text,
            // 'SecondaryAddress': secondaryAddTEC.text,
            // 'EmailAddress': emailTEC.text,
            // 'PinCode': pincodeTEC.text,
            // 'MobileNo': mobileNumTEC.text,
            // 'TelephoneNo': altMobileNumTEC.text,
            // }
            ));
    log('profileData: response ${response.body}');
    var updateProfileResponse = UpdateProfile.fromJson(response.body);
    return updateProfileResponse;
    // if (response.statusCode == 200) {
    //   // await fetchAlumniData();
    //   // Navigator.pop(context);
    //   // return  response.body;
    // } else {
    //   print('Failed to update data. Status code: ${response.statusCode}');
    // }
  }

  String toJson() => json.encode(toMap());

  factory UpdateProfile.fromJson(String source) => UpdateProfile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UpdateProfile(EmailAddress: $EmailAddress, FirstName: $FirstName, MiddleName: $MiddleName, LastName: $LastName, FullName: $FullName, Branch: $Branch, Program: $Program, PassoutYear: $PassoutYear, CompanyName: $CompanyName, Membership: $Membership, IsMembershipVerified: $IsMembershipVerified, HasMoreData: $HasMoreData, Gender: $Gender, DOB: $DOB, PrimaryAddress: $PrimaryAddress, SecondaryAddress: $SecondaryAddress, PinCode: $PinCode, MobileNo: $MobileNo, TelephoneNo: $TelephoneNo, CompanyAddress: $CompanyAddress, Designation: $Designation, IsRegistrationApproved: $IsRegistrationApproved, MembershipTypeId: $MembershipTypeId, IsRejected: $IsRejected, CountryName: $CountryName, StateName: $StateName, CityName: $CityName, ProfilePic: $ProfilePic, ProfilePicPath: $ProfilePicPath, LatestCertificate: $LatestCertificate, LatestCertificatePath: $LatestCertificatePath, IsActive: $IsActive, IsDeleted: $IsDeleted, CreatedOn: $CreatedOn, CreatedBy: $CreatedBy, ModifiedOn: $ModifiedOn, ModifiedBy: $ModifiedBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UpdateProfile &&
        other.EmailAddress == EmailAddress &&
        other.FirstName == FirstName &&
        other.MiddleName == MiddleName &&
        other.LastName == LastName &&
        other.FullName == FullName &&
        other.Branch == Branch &&
        other.Program == Program &&
        other.PassoutYear == PassoutYear &&
        other.CompanyName == CompanyName &&
        other.Membership == Membership &&
        other.IsMembershipVerified == IsMembershipVerified &&
        other.HasMoreData == HasMoreData &&
        other.Gender == Gender &&
        other.DOB == DOB &&
        other.PrimaryAddress == PrimaryAddress &&
        other.SecondaryAddress == SecondaryAddress &&
        other.PinCode == PinCode &&
        other.MobileNo == MobileNo &&
        other.TelephoneNo == TelephoneNo &&
        other.CompanyAddress == CompanyAddress &&
        other.Designation == Designation &&
        other.IsRegistrationApproved == IsRegistrationApproved &&
        other.MembershipTypeId == MembershipTypeId &&
        other.IsRejected == IsRejected &&
        other.CountryName == CountryName &&
        other.StateName == StateName &&
        other.CityName == CityName &&
        other.ProfilePic == ProfilePic &&
        other.ProfilePicPath == ProfilePicPath &&
        other.LatestCertificate == LatestCertificate &&
        other.LatestCertificatePath == LatestCertificatePath &&
        other.IsActive == IsActive &&
        other.IsDeleted == IsDeleted &&
        other.CreatedOn == CreatedOn &&
        other.CreatedBy == CreatedBy &&
        other.ModifiedOn == ModifiedOn &&
        other.ModifiedBy == ModifiedBy;
  }

  @override
  int get hashCode {
    return EmailAddress.hashCode ^
        FirstName.hashCode ^
        MiddleName.hashCode ^
        LastName.hashCode ^
        FullName.hashCode ^
        Branch.hashCode ^
        Program.hashCode ^
        PassoutYear.hashCode ^
        CompanyName.hashCode ^
        Membership.hashCode ^
        IsMembershipVerified.hashCode ^
        HasMoreData.hashCode ^
        Gender.hashCode ^
        DOB.hashCode ^
        PrimaryAddress.hashCode ^
        SecondaryAddress.hashCode ^
        PinCode.hashCode ^
        MobileNo.hashCode ^
        TelephoneNo.hashCode ^
        CompanyAddress.hashCode ^
        Designation.hashCode ^
        IsRegistrationApproved.hashCode ^
        MembershipTypeId.hashCode ^
        IsRejected.hashCode ^
        CountryName.hashCode ^
        StateName.hashCode ^
        CityName.hashCode ^
        ProfilePic.hashCode ^
        ProfilePicPath.hashCode ^
        LatestCertificate.hashCode ^
        LatestCertificatePath.hashCode ^
        IsActive.hashCode ^
        IsDeleted.hashCode ^
        CreatedOn.hashCode ^
        CreatedBy.hashCode ^
        ModifiedOn.hashCode ^
        ModifiedBy.hashCode;
  }
}
