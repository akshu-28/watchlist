import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/bloc/watchlist/watchlist_bloc.dart';
import 'package:watchlist/model/watchlist_model.dart';
import 'package:watchlist/ui/screens/confirm_page.dart';
import 'package:watchlist/ui/widgets/app_scaffold.dart';

import '../widgets/text_widget.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({Key? key}) : super(key: key);

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  late WatchlistBloc watchlistBloc;
  @override
  void initState() {
    watchlistBloc = BlocProvider.of<WatchlistBloc>(context)
      ..stream.listen((event) {});
    watchlistBloc.add(FetchWatchlist());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Appscaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 35),
              child: TextWidget(
                "MSIL WatchLIST",
                size: 18,
                fontweight: FontWeight.bold,
              ),
            ),
            BlocBuilder<WatchlistBloc, WatchlistState>(
              builder: (context, state) {
                if (state is WatchlistDone) {
                  Data watchlist = state.watchlist.response.data;
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: watchlist.symbols.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemBuilder: (context, index) {
                      return ExpandableNotifier(
                          child: Builder(builder: (context) {
                        return Column(children: [
                          ScrollOnExpand(
                              child: ExpandablePanel(
                            theme: const ExpandableThemeData(
                              hasIcon: false,
                              useInkWell: true,
                            ),
                            collapsed: Container(
                              height: 1,
                            ),
                            header: bodyData(context, watchlist, index),
                            expanded: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, "/confirmpage",
                                            arguments: ConfirmArgs(
                                                watchlist.symbols[index]));
                                      },
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.green),
                                      child: const TextWidget(
                                        "BUY",
                                        color: Colors.white,
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, "/confirmpage",
                                            arguments: ConfirmArgs(
                                                watchlist.symbols[index]));
                                      },
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.red),
                                      child: const TextWidget(
                                        "SELL",
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                            ),
                          ))
                        ]);
                      }));

                      //bodyData(context, watchlist, index);
                    },
                  );
                }

                if (state is WatchlistError) return const ErrorsWidget();
                return loadData(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Container bodyData(BuildContext context, Data watchlist, int index) {
    return Container(
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    watchlist.symbols[index].dispSym.toString(),
                    fontweight: FontWeight.w500,
                    size: 16,
                  ),
                  const Divider(
                    height: 5,
                    color: Colors.transparent,
                  ),
                  TextWidget(
                    watchlist.symbols[index].companyName.toString(),
                    size: 13,
                  ),
                ],
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextWidget(
                      watchlist.symbols[index].sym.exc,
                      size: 13,
                      color: Colors.pink[300],
                    ),
                  ],
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: TextWidget(
                      watchlist.symbols[index].excToken.toString(),
                      color: Colors.red,
                      size: 15,
                    ),
                  ),
                  const Divider(
                    height: 5,
                    color: Colors.transparent,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextWidget(
                          watchlist.symbols[index].haircut.toString(),
                          color: Colors.orange,
                          size: 13,
                        ),
                      ),
                      TextWidget(
                        watchlist.symbols[index].sym.lotSize.toString(),
                        color: Colors.green,
                        size: 13,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget loadData(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Center(
          child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      )),
    );
  }
}

class ErrorsWidget extends StatelessWidget {
  const ErrorsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          size: 60,
          color: Colors.red[900],
        ),
        const Text("Unknown Error")
      ],
    ));
  }
}