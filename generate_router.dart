import 'dart:io';

void main() {
  final directories = [
    'e:/Evoeline/lib/screens',
    'e:/Evoeline/lib/screens1-22',
  ];
  final imports = <String>[];
  final routes = <String>[];

  final classRegex = RegExp(r'class\s+(Screen[a-zA-Z0-9_]+)\s+extends');
  final routeNameRegex = RegExp(r'Screen\d+(.*)');

  for (final dirPath in directories) {
    final dir = Directory(dirPath);
    if (!dir.existsSync()) continue;

    for (final entity in dir.listSync()) {
      if (entity is File && entity.path.endsWith('.dart')) {
        final content = entity.readAsStringSync();
        final match = classRegex.firstMatch(content);
        if (match != null) {
          final className = match.group(1)!;
          final filename = entity.uri.pathSegments.last;
          final relDir = dirPath.contains('screens1-22')
              ? 'screens1-22'
              : 'screens';
          imports.add("import '../$relDir/$filename';");

          final routeNameMatch = routeNameRegex.firstMatch(className);
          String routeName;
          String routePath;

          if (routeNameMatch != null && routeNameMatch.group(1)!.isNotEmpty) {
            final namePart = routeNameMatch.group(1)!;
            routeName = namePart[0].toLowerCase() + namePart.substring(1);
            routePath = '/$routeName';
            if (routeName.toLowerCase().contains('splash') ||
                className == 'Screen1Splash') {
              routePath = '/';
              routeName = 'splash';
            }
          } else {
            routeName = className.toLowerCase();
            routePath = '/$routeName';
          }

          routes.add('''
      GoRoute(
        path: '$routePath',
        name: '$routeName',
        builder: (context, state) => const $className(),
      ),''');
        }
      }
    }
  }

  final template =
      """
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

${imports.join('\n')}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
${routes.join('')}
    ],
  );
});
""";

  File('e:/Evoeline/lib/router/app_router.dart').writeAsStringSync(template);
  print('Generated ${routes.length} routes.');
}
