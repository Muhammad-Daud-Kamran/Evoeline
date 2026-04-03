import os
import re

directories = ['e:/Evoeline/lib/screens', 'e:/Evoeline/lib/screens1-22']
imports = []
routes = []

for idx, directory in enumerate(directories):
    if not os.path.exists(directory): continue
    for filename in os.listdir(directory):
        if not filename.endswith('.dart'): continue
        filepath = os.path.join(directory, filename)
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
            match = re.search(r'class\s+(Screen[a-zA-Z0-9_]+)\s+extends', content)
            if match:
                class_name = match.group(1)
                rel_dir = 'screens' if 'screens/' in filepath.replace('\\', '/') else 'screens1-22'
                imports.append(f"import '../{rel_dir}/{filename}';")
                
                route_name_match = re.search(r'Screen\d+(.*)', class_name)
                if route_name_match:
                    name_part = route_name_match.group(1)
                    if not name_part:
                        route_name = class_name.lower()
                        route_path = f'/{route_name}'
                    else:
                        route_name = name_part[0].lower() + name_part[1:]
                        route_path = f'/{route_name}'
                        # Special case for splash
                        if 'splash' in route_name.lower() or class_name == 'Screen1Splash':
                            route_path = '/'
                            route_name = 'splash'
                else:
                    route_name = class_name.lower()
                    route_path = f'/{route_name}'
                    
                routes.append(f"""
      GoRoute(
        path: '{route_path}',
        name: '{route_name}',
        builder: (context, state) => const {class_name}(),
      ),""")

imports_str = '\n'.join(imports)
routes_str = ''.join(routes)

template = f"""import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

{imports_str}

final routerProvider = Provider<GoRouter>((ref) {{
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [{routes_str}
    ],
  );
}});
"""

with open('e:/Evoeline/lib/router/app_router.dart', 'w', encoding='utf-8') as f:
    f.write(template)

print(f"Generated {len(routes)} routes.")
