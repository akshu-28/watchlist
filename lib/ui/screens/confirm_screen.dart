import 'package:flutter/material.dart';
import 'package:watchlist/constants/app_constants.dart';
import 'package:watchlist/constants/route_name.dart';
import 'package:watchlist/ui/widgets/app_scaffold.dart';
import 'package:watchlist/ui/widgets/text_widget.dart';

import '../../model/watchlist_model.dart';

class ConfirmArgs {
  final Symbols data;

  ConfirmArgs(this.data);
}

class Confirmpage extends StatefulWidget {
  final ConfirmArgs args;
  const Confirmpage({Key? key, required this.args}) : super(key: key);

  @override
  State<Confirmpage> createState() => _ConfirmpageState();
}

class _ConfirmpageState extends State<Confirmpage> {
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
              "Back",
              color: Colors.blue,
            )
          ]),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TextWidget(
                AppConstants.watchlist,
                size: 25,
              ),
              const SizedBox(
                height: 20,
              ),
              rowData(context, AppConstants.name, widget.args.data.excToken),
              rowData(
                  context, AppConstants.detail, widget.args.data.companyName),
              rowData(context, AppConstants.ltp, widget.args.data.excToken),
              rowData(context, AppConstants.change, widget.args.data.haircut),
              rowData(context, AppConstants.changePercent,
                  widget.args.data.sym.lotSize),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.acknowScreen);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      backgroundColor: Colors.green,
                    ),
                    child: const TextWidget(
                      AppConstants.submit,
                      color: Colors.white,
                    )),
              )
            ],
          ),
        ));
  }

  Widget rowData(BuildContext context, String? data1, String? data2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Center(
                  child: TextWidget(
                data1 ?? "",
                size: 16,
              ))),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Center(
                  child: TextWidget(
                data2 ?? "",
                size: 16,
              )))
        ],
      ),
    );
  }
}
