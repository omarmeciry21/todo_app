import 'package:bloc_todo/data/models/todo.dart';
import 'package:bloc_todo/ui/cubit/cubit.dart';
import 'package:bloc_todo/ui/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneList extends StatelessWidget {
  const DoneList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TodoCubit cubit = TodoCubit.get(context);
        final doneList = cubit.tasks
            .where((element) => element.state == DONE_STATE)
            .toList();
        return doneList.length == 0
            ? Center(
                child: Text("No Done Items..."),
              )
            : ListView.builder(
                itemCount: doneList.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Todo Actions"),
                              content: Text(
                                  "What action do you want to do on this item?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    cubit.deleteTodo(doneList[index]);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Delete"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    doneList[index].state = ARCHIVED_STATE;
                                    cubit.updateTodo(doneList[index]);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Archive"),
                                ),
                              ],
                            ));
                  },
                  title: Text(doneList[index].title!),
                  subtitle: Text(doneList[index].time!),
                  leading: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(60)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          doneList[index].date!,
                          style: TextStyle(color: Colors.white),
                          overflow: TextOverflow.fade,
                          softWrap: true,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
