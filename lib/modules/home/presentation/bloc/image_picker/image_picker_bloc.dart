import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_event.dart';

part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ValueNotifier<String?> pickedImageFile = ValueNotifier<String>('');

  ImagePickerBloc() : super(const ImagePickerState(images: [])) {
    on<OpenCamera>(
      (event, emit) async {
        final response = await pickImage(ImageSource.camera);
        if (response != "") {
          pickedImageFile.value = response;
        } else {
          print("Error");
        }
      },
    );

    on<OpenGallery>(
      (event, emit) async {
        final response = await pickImage(ImageSource.gallery);
        if (response != "") {
          pickedImageFile.value = response;
        } else {
          print("Error");
        }
      },
    );

    on<RemoveImage>((event, emit) {
      final List<XFile> updatedImages = List.from(state.images);
      updatedImages.removeAt(event.index);
      emit(state.copyWith(images: updatedImages));
    });

  }

  FutureOr<String> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return "";
      return image.path;
    } on IOException catch (e) {
      return e.toString();
    } catch (e) {
      rethrow;
    }
  }

}
