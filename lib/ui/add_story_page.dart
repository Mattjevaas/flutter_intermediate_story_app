import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/locale/auth_local_datasource.dart';
import '../provider/add_story_provider.dart';
import '../service/api_service.dart';
import '../service/auth_service.dart';

class AddStoryPage extends StatelessWidget {
  const AddStoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Story"),
        ),
        body: ChangeNotifierProvider<AddStoryProvider>(
          create: (_) => AddStoryProvider(
            apiService: ApiService(),
            authService: AuthService(
              locale:
                  AuthLocalDatasource(prefs: SharedPreferences.getInstance()),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // --- Image  ---
                  Consumer<AddStoryProvider>(
                    builder: (context, value, child) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: value.imageFile != null
                            ? Image.file(
                                File(value.imageFile!.path.toString()),
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "assets/images/placeholder.png",
                              ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // --- Picker Button ---
                  Consumer<AddStoryProvider>(
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              value.getImage(ImageSource.camera);
                            },
                            child: const Text(
                              "Camera",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          TextButton(
                            onPressed: () {
                              value.getImage(ImageSource.gallery);
                            },
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith(
                                (states) => const Color(0xFFF5A1A1),
                              ),
                            ),
                            child: const Text(
                              "Galery",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  // --- Description Text Field ---
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Consumer<AddStoryProvider>(
                    builder: (context, value, child) {
                      return TextField(
                        controller: value.descController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Isi deskripsi gambar",
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 40.0, horizontal: 20),
                        ),
                      );
                    },
                  ),

                  // ---- Location Field ----
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Address",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Consumer<AddStoryProvider>(
                    builder: (context, value, child) {
                      return TextField(
                        controller: value.addressController,
                        enabled: false,
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      );
                    },
                  ),
                  Consumer<AddStoryProvider>(
                    builder: (context, value, child) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: value.currLatLon != null
                              ? () async {
                                  final data = await context.push(
                                    '/maps/${value.currLatLon!.latitude}/${value.currLatLon!.longitude}',
                                  );

                                  if (data != null) {
                                    final cast = data as LatLng;
                                    value.getPosition(
                                      lat: cast.latitude,
                                      lon: cast.longitude,
                                    );
                                  }
                                }
                              : null,
                          child: Text(
                            "Ubah Lokasi",
                            style: TextStyle(
                              color: value.currLatLon != null
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // --- Upload Button ---
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: Consumer<AddStoryProvider>(
                        builder: (ctx, value, child) {
                          return ElevatedButton(
                            onPressed: value.isLoading
                                ? null
                                : () {
                                    value.uploadImage(context);
                                  },
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: value.isLoading
                                  ? const SizedBox(
                                      height: 20.0,
                                      width: 20.0,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      "Upload",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                            ),
                          );
                        },
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
