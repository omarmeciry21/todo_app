import 'package:bloc_todo/ui/components/add_todo_sheet.dart';
import 'package:bloc_todo/ui/components/bottom_nav_bar.dart';
import 'package:bloc_todo/ui/cubit/cubit.dart';
import 'package:bloc_todo/ui/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TodoCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.selectedIndex]),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (contexts) => AddTodoSheet());
            },
            child: Icon(Icons.add),
          ),
          bottomNavigationBar: CustomBottomNavBar(),
          body: SafeArea(
            child: cubit.screens[cubit.selectedIndex],
          ),
        );
      },
    );
  }
}
