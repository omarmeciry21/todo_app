import 'package:bloc_todo/data/models/todo.dart';
import 'package:bloc_todo/ui/cubit/cubit.dart';
import 'package:bloc_todo/ui/cubit/states.dart';
import 'package:bloc_todo/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoSheet extends StatelessWidget {
  AddTodoSheet({Key? key}) : super(key: key);
  String titleText = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final TodoCubit cubit = TodoCubit.get(context);

        return Padding(
          padding: EdgeInsets.only(
            top: 8.0,
            right: 8.0,
            left: 8.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: BottomSheet(
            enableDrag: true,
            onClosing: () {},
            builder: (context) => Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        cubit.updateNewTodoTitle(value);
                      },
                      decoration: buildInputDecoration("Title"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        final chosenTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                              hour: DateTime.now().hour,
                              minute: DateTime.now().minute),
                        );
                        if (chosenTime != null)
                          cubit.updateNewTodoTime(chosenTime);
                      },
                      child: TextField(
                        controller: TextEditingController(text: cubit.todotime),
                        enabled: false,
                        decoration: buildInputDecoration("Time"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        final chosenDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            Duration(days: 30),
                          ),
                        );
                        if (chosenDate != null)
                          cubit.updateNewTodoDate(chosenDate);
                      },
                      child: TextField(
                        controller: TextEditingController(text: cubit.tododate),
                        enabled: false,
                        decoration: buildInputDecoration("Date"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        cubit.insertTodo(
                          Todo(
                            title: cubit.todotitle,
                            time: cubit.todotime,
                            date: cubit.tododate,
                            state: DOING_STATE,
                          ),
                        );
                        cubit.tododate = '';
                        cubit.todotime = '';
                        cubit.todotitle = '';
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Add Item",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
