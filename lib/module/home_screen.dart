import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/note_model.dart';
import 'package:todo_app/module/edit_note.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: const Text('Notes'),
          ),
          body: ConditionalBuilder(
            condition: AppCubit.get(context).notes.isNotEmpty,
            builder: (context) => ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemBuilder: (context, index) => noteBuilder(
                  AppCubit.get(context).notes[index], context, index),
              itemCount: AppCubit.get(context).notes.length,
            ),
            fallback: (context) => const Center(
                child: Text(
              'There is no note, Add new by +',
              style: TextStyle(fontSize: 16.0),
            )),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (AppCubit.get(context).isBottomSheetShowen) {
                if (formKey.currentState!.validate()) {
                  AppCubit.get(context).addNote(
                      title: titleController.text,
                      description: descriptionController.text);
                  titleController.text = '';
                  descriptionController.text = '';
                  Navigator.pop(context);
                }
              } else {
                scaffoldKey.currentState
                    ?.showBottomSheet(
                      (context) => Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultFormField(
                                  controller: titleController,
                                  keyboardTybe: TextInputType.text,
                                  prefixIcon: Icons.title,
                                  label: 'Title',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Title can\'t be empty';
                                    }
                                    return null;
                                  }),
                              const SizedBox(
                                height: 10.0,
                              ),
                              defaultFormField(
                                controller: descriptionController,
                                keyboardTybe: TextInputType.text,
                                prefixIcon: Icons.description_outlined,
                                label: 'Description',
                              ),
                            ],
                          ),
                        ),
                      ),
                      elevation: 0.0,
                    )
                    .closed
                    .then((value) {
                  AppCubit.get(context)
                      .changeBottomSheetState(false, Icons.edit);
                });
                AppCubit.get(context).changeBottomSheetState(true, Icons.add);
              }
            },
            backgroundColor: Colors.amber,
            child: Icon(
              AppCubit.get(context).fabIcon,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  Widget noteBuilder(NoteModel model, context, index) => InkWell(
        onTap: () {
          navigateTo(
              context,
              EditNoteScreen(
                model: model,
                index: index,
              ));
        },
        child: Card(
          color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title!,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        model.description!,
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          AppCubit.get(context).removeNote(index: index);
                        },
                        icon: const Icon(Icons.delete)),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '${model.date}',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.white60,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
