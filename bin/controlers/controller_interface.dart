import 'package:shelf_router/shelf_router.dart';

abstract class IController {
  Router router;
  IController({required this.router});
  IController addHandlers();
}
