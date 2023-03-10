import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/data/locale/auth_local_datasource.dart';
import 'package:flutter_intermediate_story_app/provider/login_provider.dart';
import 'package:flutter_intermediate_story_app/service/api_service.dart';
import 'package:flutter_intermediate_story_app/service/auth_service.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          EdgeInsets currentPadding;

          if (constraints.maxWidth > 900) {
            currentPadding = const EdgeInsets.only(left: 200, right: 200);
          } else {
            currentPadding = const EdgeInsets.all(30);
          }

          return ChangeNotifierProvider<LoginProvider>(
            create: (_) => LoginProvider(
              apiService: ApiService(),
              authService: AuthService(
                locale: AuthLocalDatasource(
                  prefs: SharedPreferences.getInstance(),
                ),
              ),
            ),
            child: Container(
              padding: currentPadding,
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Header Text ---
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Selamat Datang!",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Silahkan login untuk masuk kedalam app",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),

                        // --- Username & Password Textfield
                        const SizedBox(height: 40),
                        Consumer<LoginProvider>(
                          builder: (context, value, child) {
                            return Column(
                              children: [
                                TextField(
                                  controller: value.emailController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Masukkan Email",
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller: value.passwordController,
                                  obscureText: value.isHide,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    hintText: "Masukkan Password",
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        value.isHide
                                            ? Icons.remove_red_eye_outlined
                                            : Icons.remove_red_eye,
                                      ),
                                      onPressed: () {
                                        value.onChangeObscure();
                                      },
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),

                        // --- Button Login ----
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            Expanded(child: Consumer<LoginProvider>(
                              builder: (ctx, value, child) {
                                return ElevatedButton(
                                  onPressed: value.isLoading
                                      ? null
                                      : () {
                                          value.userLogin(context);
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
                                        : const Text("SIGN IN"),
                                  ),
                                );
                              },
                            )),
                          ],
                        ),

                        // --- Regsiter Page Offer ---
                        const SizedBox(height: 30),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: 'Belum punya akun ? ',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => context.push("/register"),
                                  text: 'Daftar disini',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ).copyWith(
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
