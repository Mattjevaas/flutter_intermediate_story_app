import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/data/model/request/add_story_request_model.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:image_picker/image_picker.dart';

import '../common/exception/custom_exception.dart';
import '../service/api_service.dart';
import '../service/auth_service.dart';

class AddStoryProvider extends ChangeNotifier {
  final ApiService _apiService;
  final AuthService _authService;

  final TextEditingController _descController = TextEditingController();

  AddStoryProvider({
    required ApiService apiService,
    required AuthService authService,
  })  : _apiService = apiService,
        _authService = authService;

  XFile? _imageFile;
  bool _isLoading = false;

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  TextEditingController get descController => _descController;
  XFile? get imageFile => _imageFile;
  bool get isLoading => _isLoading;

  Future<void> getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );

    if (photo != null) {
      _imageFile = photo;
      notifyListeners();
    }
  }

  Future<void> uploadImage(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    if (imageFile != null && _descController.text.isNotEmpty) {
      final storyData = AddStoryRequestModel(
        description: _descController.text,
        image: imageFile!,
      );

      final userData = await _authService.getUserData();

      if (userData != null) {
        try {
          final response =
              await _apiService.uploadImage(userData.token, storyData);

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(response.message),
            ));
            context.pop();
          }
        } on CustomException catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(e.message),
            ));
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(e.toString()),
            ));
          }
        }
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Silahkan lengkapi data terlebih dahulu"),
          ),
        );
      }
    }

    _isLoading = false;
    notifyListeners();
  }
}
