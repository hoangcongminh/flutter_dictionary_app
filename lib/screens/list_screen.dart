import 'package:dictionary/model/word_response.dart';
import 'package:dictionary/screens/detail_screen.dart';
import 'package:dictionary/values/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  final List<WordResponse> words;

  ListScreen(this.words);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          leading: InkWell(
            child: Icon(Icons.arrow_back_ios_new),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: AppColors.secondColor,
        body: ListView.separated(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(16),
          itemBuilder: (context, index) => ListTile(
            title: Text(
              '${words[index].word}',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 24,
              ),
            ),
            leading: Text(
              '${index + 1}',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    words[index],
                  ),
                ),
              );
            },
          ),
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey,
          ),
          itemCount: words.length,
        ),
      ),
    );
  }
}
