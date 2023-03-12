import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/common/config/flavor_config.dart';
import 'package:flutter_intermediate_story_app/ui/route_page.dart';
import 'package:url_strategy/url_strategy.dart';

import 'common/enumeration/flavor_type.dart';

void main() {
  FlavorConfig(
    flavorType: FlavorType.paid,
  );

  setPathUrlStrategy();
  runApp(const MyApp());
}
