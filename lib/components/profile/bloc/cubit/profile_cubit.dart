import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:zample/components/profile/bloc/cubit/profile_state.dart';

import 'package:zample/components/profile/repo/profile.dart';
import 'package:zample/components/profile/repo/profile_repository.dart';
import 'package:zample/core/bloc/auth/cubit/auth_cubit.dart';

import 'package:zample/core/services/service_locator.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository = app.get<ProfileRepository>();
  StreamSubscription<Profile> _profileSubscription;
  final AuthCubit _authCubit = app.get<AuthCubit>();

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

  Future<void> reload() async {
    await _profileSubscription?.cancel();
    initialize();
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
          // ignore: use_build_context_synchronously
          toolbarColor: Theme.of(context).highlightColor,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: true,
          hideBottomControls: true,
        ),
      );
      final Profile profile = state.profile;

      /// upload image to firebase storage
      final ref = FirebaseStorage.instance
          .ref()
          .child("users/${profile.uid}/profile.jpg");
      await ref.putFile(croppedFile);

      /// store link to image to firestore
      state.profile.copyWith(avatarUrl: await ref.getDownloadURL());

      await app.get<ProfileRepository>().update(
            profile: Profile(
              description: state.profile.description,
              avatarUrl: await ref.getDownloadURL(),
              email: state.profile.email,
              uid: state.profile.uid,
              username: state.profile.username,
            ),
          );

      emit(state);
    }
  }

  Future<void> updateDescription(String description) async {
    emit(
      state.copyWith(
        profile: state.profile.copyWith(description: description),
      ),
    );
    emit(state);
  }

  Future<void> writeNewDescription() async {
    final Profile profile = state.profile;

    await app.get<ProfileRepository>().update(
          profile: profile.copyWith(description: state.profile.description),
        );
  }

  Future<void> deleteAcc() async {
    await _authCubit.logOutRequested();
    await _profileRepository.deleteProfilePicture();
    await _profileRepository.delete();
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
