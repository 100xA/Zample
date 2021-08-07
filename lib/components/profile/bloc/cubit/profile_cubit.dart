import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:zample/components/profile/bloc/cubit/profile_state.dart';

import 'package:zample/components/profile/repo/profile.dart';
import 'package:zample/components/profile/repo/profile_repository.dart';

import 'package:zample/core/services/service_locator.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository = app.get<ProfileRepository>();
  StreamSubscription<Profile> _profileSubscription;
  final CollectionReference _profileCollection =
      FirebaseFirestore.instance.collection('profile');

  bool _initialized = false;
  ProfileCubit() : super(const ProfileState());

  Future<void> initialize() async {
    if (!_initialized) {
      final Profile profile = await _profileRepository.get();
      emit(state.copyWith(profile: profile));
      _profileSubscription = _profileRepository.profileStream.listen(
        (data) => emit(state.copyWith(profile: data)),
      );
      _initialized = true;
    }
  }

  /// This method picks an image from the gallery, uploads it to firebase storage
  /// and connects it by storing the link of the image to the users firestore document
  Future<void> pickNewImage(BuildContext context) async {
    /// pick the image from gallery
    final XFile pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (null != pickedFile) {
      // crop image
      final File croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1.875),
        compressFormat: ImageCompressFormat.jpg,
        maxHeight: 500,
        maxWidth: 500,
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: "Mein Profilbild",
          toolbarColor: Theme.of(context).highlightColor,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: true,
          hideBottomControls: true,
        ),
      );
      Profile profile = state.profile;

      /// upload image to firebase storage
      final ref = FirebaseStorage.instance
          .ref()
          .child("users/${profile.uid}/profile.jpg");
      await ref.putFile(croppedFile);

      /// store link to image to firestore
      state.profile.copyWith(avatarUrl: await ref.getDownloadURL());
      print(ref.getDownloadURL().toString());
      await app.get<ProfileRepository>().update(
              profile: Profile(
            description: state.profile.description,
            avatarUrl: await ref.getDownloadURL(),
            email: state.profile.email,
            uid: state.profile.uid,
            username: state.profile.username,
          ));

      emit(state);
    }
  }

  Future<void> writeNewDescription(String description) async {
    print("Das setze ich rein " + description);
    //TODO: [ZAMP-172]: The method update() does not allow to be copywith()
    await app.get<ProfileRepository>().update(
            profile: Profile(
          description: description,
          avatarUrl: state.profile.avatarUrl,
          email: state.profile.email,
          uid: state.profile.uid,
          username: state.profile.username,
        ));
    emit(state);
  }

  @override
  Future<void> close() {
    _profileSubscription?.cancel();
    return super.close();
  }

  void reset() {
    _initialized = false;
  }
}
