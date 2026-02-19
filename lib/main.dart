import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection.dart';
import 'features/reels/presentation/bloc/reels_bloc.dart';
import 'features/reels/presentation/pages/reels_page.dart';

void main() {
  init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ReelsBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ReelsPage(),
      ),
    );
  }
}
