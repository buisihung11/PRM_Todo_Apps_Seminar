import 'dart:async';
import 'dart:developer' as developer;

import 'package:TodoApp_Seminar_PRM/database/databaseHelper.dart';
import 'package:bloc/bloc.dart';
import 'package:TodoApp_Seminar_PRM/blocs/category/index.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final DatabaseHelper db = DatabaseHelper.db;

  @override
  CategoryState get initialState => CategoryLoadInProgress();

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    try {
      if (event is LoadCategory) {
        final categories = await db.getAllCategories();
        yield CategoryLoadSuccess(categories);
      }
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'CategoryBloc', error: _, stackTrace: stackTrace);
      // yield state;
    }
  }
}
