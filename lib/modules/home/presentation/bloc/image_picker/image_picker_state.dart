part of 'image_picker_bloc.dart';

class ImagePickerState extends Equatable {
  final List<XFile?> images;

  const ImagePickerState({required this.images});

  ImagePickerState copyWith({List<XFile?>? images}) {
    return ImagePickerState(images: images ?? this.images);
  }

  @override
  List<Object?> get props => [images];
}
