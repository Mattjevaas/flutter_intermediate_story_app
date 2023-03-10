import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/data/locale/auth_local_datasource.dart';
import 'package:flutter_intermediate_story_app/provider/home_provider.dart';
import 'package:flutter_intermediate_story_app/service/api_service.dart';
import 'package:flutter_intermediate_story_app/service/auth_service.dart';
import 'package:flutter_intermediate_story_app/widgets/custom_error.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/enumeration/result_state_enum.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(
        apiService: ApiService(),
        authService: AuthService(
          locale: AuthLocalDatasource(prefs: SharedPreferences.getInstance()),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Story"),
          actions: [
            Center(
                child: Text(
              "Logout",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.white),
            )),
            Consumer<HomeProvider>(
              builder: (ctx, value, child) {
                return IconButton(
                  onPressed: () {
                    value.userLogout(context);
                  },
                  icon: const Icon(Icons.logout),
                );
              },
            )
          ],
        ),
        floatingActionButton: Consumer<HomeProvider>(
          builder: (context, value, child) {
            return FloatingActionButton(
              onPressed: () async {
                await context.push("/add");
                value.refreshData();
              },
              child: const Icon(
                Icons.add,
              ),
            );
          },
        ),
        body: Consumer<HomeProvider>(
          builder: (context, value, child) {
            if (value.state == ResultState.hasData) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 30),
                  itemCount: value.listStory.length,
                  itemBuilder: (context, index) {
                    final data = value.listStory[index];

                    return Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10.0),
                      shadowColor: Colors.black12,
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            context.push("/detail/${data.id}");
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                                child: Image.network(
                                  data.photoUrl,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;

                                    return Image.asset(
                                      "assets/images/placeholder.png",
                                      fit: BoxFit.cover,
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(Icons.error),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      data.description,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (value.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return CustomErrorWidget(
                refresh: () => value.refreshData,
              );
            }
          },
        ),
      ),
    );
  }
}
