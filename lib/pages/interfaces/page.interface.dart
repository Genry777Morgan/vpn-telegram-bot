abstract class PageInterface {
  PageInterface() {
    register();
  }

  String get name;

  void render(int chatId);

  void register();
}
