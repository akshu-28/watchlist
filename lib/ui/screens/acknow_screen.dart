import 'package:flutter/material.dart';
import 'package:watchlist/constants/app_constants.dart';
import 'package:watchlist/constants/route_name.dart';
import 'package:watchlist/ui/widgets/app_scaffold.dart';
import 'package:watchlist/ui/widgets/text_widget.dart';

class Acknowledge extends StatelessWidget {
  const Acknowledge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Appscaffold(
      title: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(children: const [
          Icon(
            Icons.arrow_back_ios,
            color: Colors.blue,
          ),
          TextWidget(
            AppConstants.back,
            color: Colors.blue,
          )
        ]),
      ),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              alignment: Alignment.bottomRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, RouteName.registerScreen);
                  },
                  child: const TextWidget(
                    AppConstants.logout,
                    color: Colors.blue,
                    size: 17,
                  ))),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: const Center(
                  child: TextWidget(
                AppConstants.success,
                size: 30,
                color: Colors.red,
                fontweight: FontWeight.bold,
              ))),
        ],
      ),
    );
  }
}
