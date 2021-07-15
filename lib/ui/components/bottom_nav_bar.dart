import 'package:bloc_todo/ui/cubit/cubit.dart';
import 'package:bloc_todo/ui/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TodoCubit cubit = TodoCubit.get(context);

        return BottomNavigationBar(
            backgroundColor: Colors.white,
            onTap: (value) {
              cubit.updateSelectedIndex(value);
            },
            currentIndex: cubit.selectedIndex,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey[400],
            items: [
              BottomNavigationBarItem(
                label: "Doing",
                icon: Icon(
                  Icons.list_rounded,
                ),
              ),
              BottomNavigationBarItem(
                label: "Done",
                icon: Icon(
                  Icons.done_outline_rounded,
                ),
              ),
              BottomNavigationBarItem(
                label: "Archived",
                icon: Icon(
                  Icons.archive_rounded,
                ),
              ),
            ]);
      },
    );
  }
}
