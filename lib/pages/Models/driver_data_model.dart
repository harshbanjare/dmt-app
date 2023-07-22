class DriverData {
  final int id;
  final String name;
  final String mobile;
  final String email;
  final String user_type;
  final String profile_pic;
  final String sdk_key;

  const DriverData({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.user_type,
    required this.profile_pic,
    required this.sdk_key,
  });

  factory DriverData.fromJson(Map<String, dynamic> json) {
    return DriverData(
      id: json['id'],
      name: json['name'],
      mobile: json['mobile'],
      email: json['email'],
      user_type: json['user_type'],
      profile_pic: json['profile_pic'],
      sdk_key: json['sdk_key'],
    );
  }

  // String get sdk_key => null;
}