import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/note_model.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class EditNoteScreen extends StatelessWidget {
  NoteModel model;
  int index;

  EditNoteScreen({super.key, required this.model, required this.index});

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = model.title!;
    descriptionController.text = model.description!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit note'),
      ),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Column(
              children: [
                defaultFormField(
                  controller: titleController,
                  keyboardTybe: TextInputType.text,
                  prefixIcon: Icons.title,
                  label: 'Title',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                defaultFormField(
                  controller: descriptionController,
                  keyboardTybe: TextInputType.text,
                  prefixIcon: Icons.description_outlined,
                  label: 'Description',
                  maxLines: 4,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                defaultButton(
                  function: () {
                    AppCubit.get(context).updateNote(
                      index: index,
                      title: titleController.text,
                      description: descriptionController.text,
                    );
                    Navigator.pop(context);
                  },
                  width: double.infinity,
                  text: 'Update',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
