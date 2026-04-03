import 'dart:io';

void main() {
  final directories = [
    'e:/Evoeline/lib/screens',
    'e:/Evoeline/lib/screens1-22',
  ];

  for (final dirPath in directories) {
    final dir = Directory(dirPath);
    if (!dir.existsSync()) continue;

    for (final entity in dir.listSync()) {
      if (entity is File && entity.path.endsWith('.dart')) {
        String content = entity.readAsStringSync();
        bool changed = false;

        if (content.contains('Navigator.pop(context)')) {
          content = content.replaceAll(
            'Navigator.pop(context)',
            'context.pop()',
          );
          changed = true;
        }
        if (content.contains('Navigator.of(context).pop()')) {
          content = content.replaceAll(
            'Navigator.of(context).pop()',
            'context.pop()',
          );
          changed = true;
        }

        if (changed &&
            !content.contains("import 'package:go_router/go_router.dart';")) {
          final importMatch = RegExp(
            'import\\\\s+[\'"].*?[\'"];\\\\n',
          ).allMatches(content);
          if (importMatch.isNotEmpty) {
            final lastMatch = importMatch.last;
            content =
                content.substring(0, lastMatch.end) +
                "import 'package:go_router/go_router.dart';\n" +
                content.substring(lastMatch.end);
          } else {
            content = "import 'package:go_router/go_router.dart';\n" + content;
          }
        }

        if (changed) {
          entity.writeAsStringSync(content);
          print('Updated ${entity.uri.pathSegments.last}');
        }
      }
    }
  }
}
