class EmployeeModel {
  int? id;
  String? firstName;
  String? lastName;
  String? joinDate;
  String? dateOfBirth;
  int? designationId;
  String? gender;
  int? mobile;
  int? landline;
  String? email;
  String? presentAddress;
  String? permanentAddress;
  String? profilePicture;
  String? resume;
  String? createdAt;
  String? updatedAt;
  String? profileImage;
  String? status;

  EmployeeModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.joinDate,
      this.dateOfBirth,
      this.designationId,
      this.gender,
      this.mobile,
      this.landline,
      this.email,
      this.presentAddress,
      this.permanentAddress,
      this.profilePicture,
      this.profileImage,
      this.resume,
      this.createdAt,
      this.updatedAt,
      this.status});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    joinDate = json['join_date'];
    dateOfBirth = json['date_of_birth'];
    designationId = json['designation_id'];
    gender = json['gender'];
    mobile = json['mobile'];
    profileImage = json['profile_image'];
    landline = json['landline'];
    email = json['email'];
    presentAddress = json['present_address'];
    permanentAddress = json['permanent_address'];
    profilePicture = json['profile_picture'];
    resume = json['resume'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }
}
