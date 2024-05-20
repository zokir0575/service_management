part of 'image_picker_bloc.dart';

@immutable
abstract class ImagePickerEvent {}

class OpenCamera extends ImagePickerEvent {}

class OpenGallery extends ImagePickerEvent {}

class OpenGalleryFeedback extends ImagePickerEvent {}

class RemoveImage extends ImagePickerEvent {
  final int index;

  RemoveImage({required this.index});
}

class DeleteAllImages extends ImagePickerEvent {}
