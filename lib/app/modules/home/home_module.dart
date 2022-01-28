import 'package:flutter_modular/flutter_modular.dart';
import 'package:tmdb_trending/app/modules/home/presentation/pages/home_page.dart';

class HomeModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (context, arguments) => const HomePage(),
        transition: TransitionType.rightToLeft,
        duration: const Duration(milliseconds: 400)),
  ];
}
