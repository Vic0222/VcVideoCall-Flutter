class EnvironmentConfig {
  static const SERVER_ADDRESS =
      String.fromEnvironment('SERVER_ADDRESS') ?? "10.0.2.2";
}
