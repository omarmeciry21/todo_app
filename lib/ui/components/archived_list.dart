import 'package:bloc_todo/data/models/todo.dart';
import 'package:bloc_todo/ui/cubit/cubit.dart';
import 'package:bloc_todo/ui/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchivedList extends StatelessWidget {
  const ArchivedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TodoCubit cubit = TodoCubit.get(context);
        final archivedList = cubit.tasks
            .where((element) => element.state == ARCHIVED_STATE)
            .toList();
        return archivedList.length == 0
            ? Center(
                child: Text("No Archived Items..."),
              )
            : ListView.builder(
                itemCount: archivedList.length,
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
                                    cubit.deleteTodo(archivedList[index]);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Delete"),
                                ),
                              ],
                            ));
                  },
                  title: Text(archivedList[index].title!),
                  subtitle: Text(archivedList[index].time!),
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
                          archivedList[index].date!,
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
