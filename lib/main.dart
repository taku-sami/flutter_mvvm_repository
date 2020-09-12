import 'package:flutter/material.dart';
import 'package:flutter_mvvm_repository/home_screen.dart';
import 'package:flutter_mvvm_repository/user_repository.dart';
import 'package:flutter_mvvm_repository/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  final userViewModel = UserViewModel(
    userRepo: UserRepository(
      prefs: await SharedPreferences.getInstance(),
    ),
  );
  await userViewModel.init();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider<UserViewModel>.value(value: userViewModel)],
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    ),
  ));
}
