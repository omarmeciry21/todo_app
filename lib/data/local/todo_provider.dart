import 'package:bloc_todo/data/models/todo.dart';
import 'package:sqflite/sqflite.dart';

final String tableTodo = 'todo';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnTime = 'time';
final String columnDate = 'date';
final String columnState = 'state';
final String dbPath = 'todo_list.db';

class TodoProvider {
  late Database db;

  TodoProvider._privateConstructor() {
    open();
  }

  ///creating single object structure
  static final TodoProvider instance = TodoProvider._privateConstructor();

  Future<void> open() async {
    await openDatabase(
      dbPath,
      version: 2,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE IF NOT EXISTS $tableTodo ($columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,$columnTitle TEXT not null,$columnTime TEXT not null,$columnDate TEXT not null,$columnState TEXT not null)');
      },
    ).then((value) => db = value);
  }

  Future<Todo> insert(Todo todo) async {
    if (!db.isOpen) instance.open();
    todo.id = await db.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<Todo?> getTodo(int id) async {
    if (!db.isOpen) instance.open();

    List<Map> maps = await db.query(tableTodo,
        columns: [
          columnId,
          columnTitle,
          columnTime,
          columnDate,
          columnState,
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Todo.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Todo>> getTodoList() async {
    if (!db.isOpen) instance.open();

    List<Map> maps = await db.query(
      tableTodo,
      columns: [
        columnId,
        columnTitle,
        columnTime,
        columnDate,
        columnState,
      ],
    );
    if (maps.length > 0) {
      return maps.map((e) => Todo.fromMap(e)).toList();
    }
    return [];
  }

  Future<int> delete(int id) async {
    if (!db.isOpen) instance.open();

    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Todo todo) async {
    if (!db.isOpen) instance.open();

    return await db.update(tableTodo, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

  Future close() async => db.close();
}
