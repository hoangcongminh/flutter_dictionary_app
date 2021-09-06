import 'package:dictionary/bloc/dictionary_cubit.dart';
import 'package:dictionary/repo/word_repo.dart';
import 'package:dictionary/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        child: HomeScreen(),
        create: (context) => DictionaryCubit(WordRepository()),
      ),
    );
  }
}
