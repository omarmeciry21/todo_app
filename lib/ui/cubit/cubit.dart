import 'package:bloc_todo/data/local/todo_provider.dart';
import 'package:bloc_todo/data/models/todo.dart';
import 'package:bloc_todo/ui/components/archived_list.dart';
import 'package:bloc_todo/ui/components/doing_list.dart';
import 'package:bloc_todo/ui/components/done_list.dart';
import 'package:bloc_todo/ui/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<AppStates> {
  TodoCubit() : super(AppInitialState());

  static TodoCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;
  final List<String> titles = ["Doing Items", "Done Items", "Archived Items"];
  final List<Widget> screens = [DoingList(), DoneList(), ArchivedList()];

  updateSelectedIndex(int value) {
    selectedIndex = value;
    emit(AppChangeBottomNavBarState());
  }

  List<Todo> tasks = [];

  openLocalDatabase() async {
    TodoProvider.instance.open().then((value) {
      print("database opened!");
      emit(AppOpenTodoDatabaseState());
      getTodoList();
    });
  }

  getTodoList() async {
    TodoProvider.instance.getTodoList().then((value) {
      tasks = value;
      print("database retrieved!");
      print(tasks.map((e) => e.toMap()).toList());
      emit(AppGetTodoListState());
    });
  }

  insertTodo(Todo todo) async {
    TodoProvider.instance.insert(todo).then((value) {
      getTodoList();
      print("database inserted!");
      emit(AppInsertTodoItemState());
    });
  }

  deleteTodo(Todo todo) async {
    TodoProvider.instance.delete(todo.id!).then((value) {
      getTodoList();
      print("database deleted!");
      emit(AppDeleteTodoItemState());
    });
  }

  updateTodo(Todo todo) async {
    TodoProvider.instance.update(todo).then((value) {
      getTodoList();
      print("database deleted!");
      emit(AppUpdateTodoItemState());
    });
  }

  String? tododate = null;
  String? todotime = null;
  String? todotitle = null;

  void updateNewTodoTime(TimeOfDay time) {
    todotime = time.hour.toString() + ":" + time.minute.toString();
    emit(AppChangeNewTodoState());
  }

  void updateNewTodoDate(DateTime date) {
    tododate = date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString();
    emit(AppChangeNewTodoState());
  }

  void updateNewTodoTitle(String? value) {
    todotitle = value;
    emit(AppChangeNewTodoState());
  }
}
