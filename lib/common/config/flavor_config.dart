import '../enumeration/flavor_type.dart';

class FlavorConfig {
  static final FlavorConfig _instance = FlavorConfig._internal();
  late FlavorType flavor;

  factory FlavorConfig({required FlavorType flavorType}) {
    _instance.flavor = flavorType;
    return _instance;
  }

  FlavorConfig._internal();

  static FlavorConfig get instance => _instance;
}
