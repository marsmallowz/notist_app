part of 'models.dart';

class RegistrationData {
  String name = "";
  String email;
  String password;
  List<String> selectedCategory;
  String selectedGender;
  File profilePicture;

  RegistrationData(
      {this.name = "",
      this.email = "",
      this.password = "",
      this.selectedCategory = const [],
      this.selectedGender = "",
      this.profilePicture});
}
