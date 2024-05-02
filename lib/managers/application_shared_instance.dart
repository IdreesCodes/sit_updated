// Singleton

class Datamanager {
  static final Datamanager _singleton = Datamanager._internal();

  factory Datamanager() {
    return _singleton;
  }

  Datamanager._internal();
}
