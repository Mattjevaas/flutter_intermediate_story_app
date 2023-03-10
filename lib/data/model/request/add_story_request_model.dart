import 'package:image_picker/image_picker.dart';

class AddStoryRequestModel {
  final String description;
  final XFile image;
  final double? lat;
  final double? lon;

  AddStoryRequestModel({
    required this.description,
    required this.image,
    this.lat,
    this.lon,
  });

  Map<String, String> toJson() {
    if (lat == null && lon == null) {
      return {
        "description": description,
      };
    }

    return {
      "description": description,
      "lat": lat?.toString() ?? "",
      "lon": lon?.toString() ?? "",
    };
  }
}
