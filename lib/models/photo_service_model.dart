import 'package:image_picker/image_picker.dart';

class PhotoServiceModel {
  final ImagePicker _picker = ImagePicker();

  Future<List<XFile>> fetchPhotos() async {
    final List<XFile>? photos = await _picker.pickMultiImage();
    return photos ?? [];
  }

  Future<List<XFile>?> pickPhotos(List<XFile> selectedPhotos) async {
    final List<XFile>? photos = await _picker.pickMultiImage();
    if (photos != null) {
      for (var photo in photos) {
        if (!selectedPhotos
            .any((selectedPhoto) => selectedPhoto.path == photo.path)) {
          selectedPhotos.add(photo);
        }
      }
    }
    return selectedPhotos;
  }
}