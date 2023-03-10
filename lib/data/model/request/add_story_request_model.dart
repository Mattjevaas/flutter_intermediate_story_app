import 'package:image_picker/image_picker.dart';

class AddStoryRequestModel {
  final String description;
  final XFile image;

  AddStoryRequestModel({
    required this.description,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
        "description": description,
      };
}
