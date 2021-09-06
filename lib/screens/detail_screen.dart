import 'package:dictionary/model/word_response.dart';
import 'package:dictionary/values/app_colors.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final WordResponse wordResponse;

  DetailScreen(this.wordResponse);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: InkWell(
          child: Icon(Icons.arrow_back_ios_new),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Text(
              "${wordResponse.word}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '/${wordResponse.phonetics![0].text.toString()}/',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final meaning = wordResponse.meanings![index];
                  final definations = meaning.definitions;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${meaning.partOfSpeech.toString()[0].toUpperCase()}${meaning.partOfSpeech.toString().substring(1)}',
                        style:
                            TextStyle(color: AppColors.textColor, fontSize: 24),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Column(
                          children: [
                            Text(
                              " - Defination : " +
                                  definations![index].definition.toString(),
                              style: TextStyle(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Sentence  : ${definations[index].example == null ? '' : definations[index].example}",
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 8,
                        ),
                        itemCount: definations!.length,
                        shrinkWrap: true,
                      )
                    ],
                  );
                },
                itemCount: wordResponse.meanings!.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: 32,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
