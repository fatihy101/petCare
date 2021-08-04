class PetOwner {
  final String uid;
  final String displayName;
  final String email;
  String? photoURL; // FIXME Photo doesn't update without hot reload. Solve with GetX
  final String? avatarName;
  final List<String>? petIDs;

  PetOwner
      ({required this.uid,
      required this.displayName,
      required this.email,
      this.petIDs,
      this.photoURL,
      this.avatarName});
}
