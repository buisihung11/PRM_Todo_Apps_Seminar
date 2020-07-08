import 'package:TodoApp_Seminar_PRM/blocs/todo/index.dart';
import 'package:TodoApp_Seminar_PRM/database/databaseHelper.dart';
import 'package:TodoApp_Seminar_PRM/database/todoModel.dart';
import 'package:bloc/bloc.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final int categoryId;
  final DatabaseHelper db = DatabaseHelper.db;

  TodosBloc({this.categoryId});

  @override
  TodosState get initialState => TodosLoadInProgress();

  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    if (event is LoadTodo) {
      yield* _mapTodosLoadedToState();
    } else if (event is TodoAdded) {
      yield* _mapTodoAddedToState(event);
    } else if (event is TodoUpdated) {
      yield* _mapTodoUpdatedToState(event);
    } else if (event is TodoDeleted) {
      yield* _mapTodoDeletedToState(event);
    }
  }

  Stream<TodosState> _mapTodosLoadedToState() async* {
    try {
      final results = await db.getAllTodos(categoryId);
      yield TodosLoadSuccess(results);
    } catch (_) {
      yield TodosLoadFailure();
    }
  }

  Stream<TodosState> _mapTodoAddedToState(TodoAdded event) async* {
    if (state is TodosLoadSuccess) {
      final addedTodo =
          await db.addTodo(event.todo.copyWith(categoryId: this.categoryId));

      final List<Todo> updatedTodos =
          List.from((state as TodosLoadSuccess).todos)..add(addedTodo);
      yield TodosLoadSuccess(updatedTodos);
    } else {
      final addedTodo = await db.addTodo(event.todo);
      // TODO yield add success for notify

    }
  }

  Stream<TodosState> _mapTodoUpdatedToState(TodoUpdated event) async* {
    if (state is TodosLoadSuccess) {
      event.todo.categoryId = this.categoryId;
      // save to DB
      final id = await db.updateTodo(event.todo);

      final result = await db.getAllTodos(categoryId);
      print(result);
      // save to Store
      final List<Todo> updatedTodos =
          (state as TodosLoadSuccess).todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      }).toList();

      yield TodosLoadSuccess(updatedTodos);
      // _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapTodoDeletedToState(TodoDeleted event) async* {
    if (state is TodosLoadSuccess) {
      final result = await db.delete(event.todo.id);
      if (result != 0) {
        final updatedTodos = (state as TodosLoadSuccess)
            .todos
            .where((todo) => todo.id != event.todo.id)
            .toList();
        yield TodosLoadSuccess(updatedTodos);
      }
    }
  }

  Stream<TodosState> _mapToggleAllToState() async* {
    if (state is TodosLoadSuccess) {
      // final allComplete =
      //     (state as TodosLoadSuccess).todos.every((todo) => todo.complete);
      // final List<Todo> updatedTodos = (state as TodosLoadSuccess)
      //     .todos
      //     .map((todo) => todo.copyWith(complete: !allComplete))
      //     .toList();
      // yield TodosLoadSuccess(updatedTodos);
      // _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapClearCompletedToState() async* {
    if (state is TodosLoadSuccess) {
      // final List<Todo> updatedTodos = (state as TodosLoadSuccess)
      //     .todos
      //     .where((todo) => !todo.complete)
      //     .toList();
      // yield TodosLoadSuccess(updatedTodos);
      // _saveTodos(updatedTodos);
    }
  }

  Future _saveTodos(List<Todo> todos) {
    // return todosRepository.saveTodos(
    //   todos.map((todo) => todo.toEntity()).toList(),
    // );
  }
}
