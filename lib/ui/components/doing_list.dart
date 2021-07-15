import 'package:bloc_todo/data/models/todo.dart';
import 'package:bloc_todo/ui/cubit/cubit.dart';
import 'package:bloc_todo/ui/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoingList extends StatelessWidget {
  const DoingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TodoCubit cubit = TodoCubit.get(context);
        final doingList = cubit.tasks
            .where((element) => element.state == DOING_STATE)
            .toList();
        return doingList.length == 0
            ? Center(
                child: Text("No Doing Items..."),
              )
            : ListView.builder(
                itemCount: doingList.length,
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
                                    cubit.deleteTodo(doingList[index]);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Delete"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    doingList[index].state = DONE_STATE;
                                    cubit.updateTodo(doingList[index]);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Done"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    doingList[index].state = ARCHIVED_STATE;
                                    cubit.updateTodo(doingList[index]);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Archive"),
                                ),
                              ],
                            ));
                  },
                  title: Text(doingList[index].title!),
                  subtitle: Text(doingList[index].time!),
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
                          doingList[index].date!,
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
