import 'package:flutter/material.dart';
import 'package:wikitrack/common/button.dart';
import 'package:wikitrack/common/commontextfield.dart';
import 'package:wikitrack/utils/AppStrings.dart';

showDataAlert(
  context, {
  required String text,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.0,
              ),
            ),
          ),
          contentPadding: EdgeInsets.only(
            top: 10.0,
          ),
          title: Text(
            text,
            style: TextStyle(fontSize: 24.0),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    commonTextField(
                      prefixIcon: Icon(Icons.search),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("hello"),
                          );
                        },
                      ),
                    ),
                    CommonButton(title: AppStrings.add)
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
