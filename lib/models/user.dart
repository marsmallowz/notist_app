part of 'models.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String profilePicture;
  final List<String> selectedCategory;
  final String selectedGender;

  User(this.id, this.email,
      {this.name,
      this.profilePicture,
      this.selectedCategory,
      this.selectedGender});

  User copyWith({String name, String profilePicture}) =>
      User(this.id, this.email,
          name: name ?? this.name,
          profilePicture: profilePicture ?? this.profilePicture,
          selectedCategory: selectedCategory,
          selectedGender: selectedGender);

  @override
  // TODO: implement props
  List<Object> get props =>
      [id, email, name, profilePicture, selectedCategory, selectedGender];
}
