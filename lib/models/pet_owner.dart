class PetOwner {
  final String uid;
  final String displayName;
  final String email;
  String? photoURL; // FIXME Photo doesn't update without hot reload. Solve with GetX
  String? avatarName;
  List<String>? petIDs;

  PetOwner
      ({required this.uid,
    required this.displayName,
    required this.email,
    this.petIDs,
    this.photoURL,
    this.avatarName});

  PetOwner.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        displayName = json["nameSurname"],
        email = json["email"],
        avatarName = json["avatar"] ?? null,
        photoURL = json["photoURL"] ?? null,
        petIDs = json["petIDs"] == null ? null : json["petIDs"] as List<String>;

}
