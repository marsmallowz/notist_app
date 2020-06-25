part of 'exstensions.dart';

extension FirebaseUserExtension on FirebaseUser {
  User convertToUser(
          {String name = "Ala",
          List<String> selectedCategory = const [],
          String selectedGender = "Perempuan"}) =>
      User(this.uid, this.email,
          name: name,
          selectedCategory: selectedCategory,
          selectedGender: selectedGender);
  Future<User> fromFireStore() async => await UserServices.getUser(this.uid);
}
