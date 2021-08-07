import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zample/components/profile/repo/profile.dart';
import 'package:zample/components/profile/repo/profile_repository.dart';

class FirebaseProfileRepository extends ProfileRepository {
  final CollectionReference _profileCollection =
      FirebaseFirestore.instance.collection('profile');

  @override
  Future<void> create({Profile profile}) async {
    return _profileCollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set(profile.toJson());
  }

  @override
  Future<void> delete() async {
    return _profileCollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .delete();
  }

  @override
  Future<Profile> get() async {
    final DocumentSnapshot document = await _profileCollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    return Profile.fromJson(document.data());
  }

  @override
  Future<bool> exists() async {
    final DocumentSnapshot document = await _profileCollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    return document.exists;
  }

  @override
  Future<void> update({Profile profile}) async {
    return _profileCollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update(profile.toJson());
  }

  @override
  Future<void> setDesc({String desc}) async {
    return _profileCollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({'description': desc});
  }

  @override
  Stream<Profile> get profileStream => _profileCollection
      .doc(FirebaseAuth.instance.currentUser.uid)
      .snapshots()
      .map((snapshot) => Profile.fromJson(snapshot.data()));
}
