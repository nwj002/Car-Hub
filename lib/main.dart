import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:n_baz/screens/auth/forget_password_screen.dart';
import 'package:n_baz/screens/auth/login_screen.dart';
import 'package:n_baz/screens/auth/register_screen.dart';
import 'package:n_baz/screens/category/single_category_screen.dart';
import 'package:n_baz/screens/dashboard/dashboard.dart';
import 'package:n_baz/screens/product/add_product_screen.dart';
import 'package:n_baz/screens/product/edit_product_screen.dart';
import 'package:n_baz/screens/product/my_product_screen.dart';
import 'package:n_baz/screens/product/single_product_screen.dart';
import 'package:n_baz/screens/splash_screen.dart';
import 'package:n_baz/services/local_notification_service.dart';
import 'package:n_baz/viewmodels/auth_viewmodel.dart';
import 'package:n_baz/viewmodels/category_viewmodel.dart';
import 'package:n_baz/viewmodels/global_ui_viewmodel.dart';
import 'package:n_baz/viewmodels/product_viewmodel.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase only once
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider (create: (_) => GlobalUIViewModel()),
        ChangeNotifierProvider (create: (_) => AuthViewModel()),
        ChangeNotifierProvider (create: (_) => CategoryViewModel()),
        ChangeNotifierProvider (create: (_) => ProductViewModel()),
      ],
      child: GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: Center(
          child: Image.asset("assets/images/loader.gif", height: 100, width: 100,),
        ),
        child: Consumer<GlobalUIViewModel>(
          builder: (context, loader, child) {
            if(loader.isLoading){
              context.loaderOverlay.show();
            }else{
              context.loaderOverlay.hide();
            }
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.green,
                textTheme: GoogleFonts.aBeeZeeTextTheme(),
              ),
              initialRoute: "/splash",
              routes: {
                "/login": (BuildContext context)=>LoginScreen(),
                "/splash": (BuildContext context)=>SplashScreen(),
                "/register": (BuildContext context)=>RegisterScreen(),
                "/forget-password": (BuildContext context)=>ForgetPasswordScreen(),
                "/dashboard": (BuildContext context)=>DashboardScreen(),
                "/add-product": (BuildContext context)=>AddProductScreen(),
                "/edit-product": (BuildContext context)=>EditProductScreen(),
                "/single-product": (BuildContext context)=>SingleProductScreen(),
                "/single-category": (BuildContext context)=>SingleCategoryScreen(),
                "/my-products": (BuildContext context)=>MyProductScreen(),
              },
            );
          }
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
