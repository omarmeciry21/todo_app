const String DOING_STATE = "doing";
const String DONE_STATE = "done";
const String ARCHIVED_STATE = "archived";

class Todo {
  int? id;
  String? title, time, date, state;

  Todo({
    this.id,
    required this.title,
    required this.time,
    required this.date,
    required this.state,
  });

  Todo.fromMap(map) {
    this.id = map["id"];
    this.title = map["title"];
    this.time = map["time"];
    this.date = map["date"];
    this.state = map["state"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "title": this.title,
      "time": this.time,
      "date": this.date,
      "state": this.state,
    };
  }
}
