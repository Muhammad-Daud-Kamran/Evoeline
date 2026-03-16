class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String profileImageUrl;
  final String bio;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.profileImageUrl,
    this.bio = '',
  });

  // Dummy Factory with sample data
  factory UserModel.dummy() {
    return UserModel(
      uid: 'u_123',
      fullName: 'John Doe',
      email: 'johndoe@example.com',
      profileImageUrl: 'https://i.pravatar.cc/150?img=11',
      bio: 'Software Developer & Event Enthusiast',
    );
  }
}
