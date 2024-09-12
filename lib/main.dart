import 'package:provider/provider.dart';

import 'core/common/app/providers/product_provider.dart';
import 'core/services/error_reporting.dart';
import 'core/services/injection_container.dart';
import 'package:flutter/material.dart';

import 'core/res/colours.dart';
import 'core/res/fonts.dart';
import 'core/services/router.dart';
import 'src/dashboard/presentation/providers/dashboard_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initUXCam();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => DashboardController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Klontong App',
        theme: ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: Fonts.inter,
          appBarTheme: const AppBarTheme(
            color: Color.fromARGB(0, 75, 68, 68),
          ),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Colours.primaryColour,
            errorColor: Colours.errorColour,
          ),
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
      ),
    );
  }
}
