import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_intermediate_story_app/common/exception/custom_exception.dart';
import 'package:flutter_intermediate_story_app/data/model/request/add_story_request_model.dart';
import 'package:flutter_intermediate_story_app/data/model/request/login_request_model.dart';
import 'package:flutter_intermediate_story_app/data/model/request/register_request_model.dart';
import 'package:flutter_intermediate_story_app/data/model/request/story_request_model.dart';
import 'package:flutter_intermediate_story_app/data/model/response/add_story_response_model.dart';
import 'package:flutter_intermediate_story_app/data/model/response/detail_story_response_model.dart';
import 'package:flutter_intermediate_story_app/data/model/response/login_response_model.dart';
import 'package:flutter_intermediate_story_app/data/model/response/register_response_model.dart';
import 'package:http/http.dart' as https;

import '../data/model/response/story_response_model.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();

  factory ApiService() => _instance;

  ApiService._internal();

  static const String _baseUrl = "https://story-api.dicoding.dev/v1";

  Future<LoginResponseModel> userLogin(LoginRequestModel loginData) async {
    final response = await https.post(
      Uri.parse("$_baseUrl/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(
        loginData.toJson(),
      ),
    );

    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      final message = json.decode(response.body)["message"];

      if (message != null) {
        throw CustomException(message: message);
      }

      throw CustomException(message: "Something Wrong");
    }
  }

  Future<RegisterResponseModel> userRegister(
    RegisterRequestModel registerData,
  ) async {
    final response = await https.post(
      Uri.parse("$_baseUrl/register"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(
        registerData.toJson(),
      ),
    );

    if (response.statusCode == 201) {
      return RegisterResponseModel.fromJson(json.decode(response.body));
    } else {
      final message = json.decode(response.body)["message"];

      if (message != null) {
        throw CustomException(message: message);
      }

      throw CustomException(message: "Something Wrong");
    }
  }

  Future<StoryResponseModel> getAllStory(
      String token, StoryRequestModel requestData) async {
    final response = await https.get(
      Uri.parse(
        "$_baseUrl/stories?page=${requestData.page}&size=${requestData.size}&location=${requestData.location}",
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return StoryResponseModel.fromJson(json.decode(response.body));
    } else {
      final message = json.decode(response.body)["message"];

      if (message != null) {
        throw CustomException(message: message);
      }

      throw CustomException(message: "Something Wrong");
    }
  }

  Future<DetailStoryResponseModel> getStoryDetail(
    String token,
    String id,
  ) async {
    final response = await https.get(
      Uri.parse("$_baseUrl/stories/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return DetailStoryResponseModel.fromJson(json.decode(response.body));
    } else {
      final message = json.decode(response.body)["message"];

      if (message != null) {
        throw CustomException(message: message);
      }

      throw CustomException(message: "Something Wrong");
    }
  }

  Future<AddStoryResponseModel> uploadImage(
    String token,
    AddStoryRequestModel storyData,
  ) async {
    final uri = Uri.parse("$_baseUrl/stories");
    var request = https.MultipartRequest('POST', uri);

    final fileName = storyData.image.name;
    final bytes = await storyData.image.readAsBytes();

    final multiPartFile =
        https.MultipartFile.fromBytes("photo", bytes, filename: fileName);

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    final Map<String, String> fields = storyData.toJson();

    request.files.add(multiPartFile);
    request.fields.addAll(fields);
    request.headers.addAll(headers);

    final https.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;

    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    if (statusCode == 201) {
      return AddStoryResponseModel.fromJson(json.decode(responseData));
    } else {
      final message = json.decode(responseData)["message"];

      if (message != null) {
        throw CustomException(message: message);
      }

      throw CustomException(message: "Something Wrong");
    }
  }
}
