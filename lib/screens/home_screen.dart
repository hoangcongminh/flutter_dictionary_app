import 'package:dictionary/bloc/dictionary_cubit.dart';
import 'package:dictionary/screens/list_screen.dart';
import 'package:dictionary/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  getDictionaryFormWidget(BuildContext context) {
    final cubit = context.watch<DictionaryCubit>();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Spacer(),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'English',
                  style: TextStyle(
                    fontSize: 66.77,
                    color: AppColors.blackGray,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    'Dictionary',
                    style: TextStyle(
                        height: 0.5, fontSize: 26, color: Colors.white),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60,
          ),
          TextField(
            controller: cubit.queryController,
            decoration: InputDecoration(
              hintText: 'Search a word',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey),
              ),
              fillColor: AppColors.lightBlue,
              filled: true,
              prefixIcon: Icon(Icons.search),
              hintStyle: TextStyle(color: AppColors.greyText),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 24),
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: () {
                cubit.getWordSearched();
              },
              style: ElevatedButton.styleFrom(
                elevation: 5,
                primary: AppColors.lightBlue,
                padding: const EdgeInsets.all(16),
              ),
              child: Text(
                'SEARCH',
                style: TextStyle(color: AppColors.textColor),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  getLoadingWidget() {
    return Center(child: CircularProgressIndicator());
  }

  getErrorWidget(message, BuildContext context) {
    final cubit = context.watch<DictionaryCubit>();
    return AlertDialog(
      backgroundColor: AppColors.lightBlue,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text(message),
      actions: [
        TextButton(
          child: const Text(
            'Back',
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            cubit.getNoWordSearched();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DictionaryCubit>();

    return BlocListener(
      listener: (context, state) {
        if (state is WordSearchedState && state.words != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListScreen(state.words),
            ),
          );
        }
      },
      bloc: cubit,
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: cubit.state is WordSearchingState
            ? getLoadingWidget()
            : cubit.state is ErrorState
                ? getErrorWidget('Error, please try again', context)
                : cubit.state is NoWordSearchedState
                    ? getDictionaryFormWidget(context)
                    : Container(),
      ),
    );
  }
}
