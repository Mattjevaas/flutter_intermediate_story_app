import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final Function? _refresh;

  const CustomErrorWidget({super.key, Function? refresh}) : _refresh = refresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 50),
          const SizedBox(height: 10),
          const Text("Oops Something Wrong!"),
          if (_refresh != null) const SizedBox(height: 5),
          TextButton(
            onPressed: _refresh!(),
            child: const Text("Retry"),
          )
        ],
      ),
    );
  }
}
