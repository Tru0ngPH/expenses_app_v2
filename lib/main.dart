import 'package:exp_app/widgets/chart.dart';

import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';

import 'package:flutter/material.dart';

void main() {
  // //Khong cho phep thiet bi xoay
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.purple, accentColor: Colors.amber)
              .copyWith(secondary: Colors.lightBlueAccent),
          fontFamily: 'OpenSans',
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            elevation: 15,
          )),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _trans = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.89,
    //   dateTime: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 69.89,
    //   dateTime: DateTime.now(),
    // ),
  ];

  void _addNewTransaction({
    required String txTitle,
    required double txAmount,
    required DateTime dateTime,
  }) {
    final newTran = Transaction(
      amount: txAmount,
      title: txTitle,
      dateTime: dateTime,
      id: DateTime.now().toString(),
    );
    setState(() {
      _trans.add(newTran);
    });
  }

  void _startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(
              addTransaction: _addNewTransaction,
            ),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  bool _showChartBar = false;
  List<Transaction> get _recentTransaction {
    return _trans.where((tx) {
      return tx.dateTime.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _deleteTran(String iD) {
    setState(() {
      _trans.removeWhere((tran) => tran.id == iD);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: const Text('Personal Expenses'),
      actions: [
        IconButton(
            onPressed: () => _startAddTransaction(context),
            icon: const Icon(
              Icons.add,
            ))
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Chart Bar'),
                    Switch(
                        value: _showChartBar,
                        onChanged: (val) {
                          setState(() {
                            _showChartBar = val;
                          });
                        }),
                  ],
                ),
              if (!isLandscape)
                SizedBox(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.3,
                    width: double.infinity,
                    child: Chart(recentTransaction: _recentTransaction)),
              if (!isLandscape)
                SizedBox(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.7,
                  child: TransactionList(
                    trans: _trans,
                    deleteTran: _deleteTran,
                  ),
                ),
              if (isLandscape)
                _showChartBar
                    ? SizedBox(
                        height: (mediaQuery.size.height -
                                appBar.preferredSize.height -
                                mediaQuery.padding.top) *
                            0.65,
                        width: double.infinity,
                        child: Chart(recentTransaction: _recentTransaction))
                    : SizedBox(
                        height: (mediaQuery.size.height -
                                appBar.preferredSize.height -
                                mediaQuery.padding.top) *
                            0.7,
                        child: TransactionList(
                          trans: _trans,
                          deleteTran: _deleteTran,
                        ),
                      )
            ],
          )

          // isLandscape
          //     ? Column(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               const Text('Chart Bar'),
          //               Switch(
          //                   value: _showChartBar,
          //                   onChanged: (val) {
          //                     setState(() {
          //                       _showChartBar = val;
          //                     });
          //                   }),
          //             ],
          //           ),
          //           (_showChartBar
          //               ? SizedBox(
          //                   height: (mediaQuery.size.height -
          //                           appBar.preferredSize.height -
          //                           mediaQuery.padding.top) *
          //                       0.65,
          //                   width: double.infinity,
          //                   child: Chart(recentTransaction: _recentTransaction))
          //               : SizedBox(
          //                   height: (mediaQuery.size.height -
          //                           appBar.preferredSize.height -
          //                           mediaQuery.padding.top) *
          //                       0.7,
          //                   child: TransactionList(
          //                     trans: _trans,
          //                     deleteTran: _deleteTran,
          //                   ),
          //                 ))
          //         ],
          //       )
          //     : Column(
          //         children: [
          //           SizedBox(
          //               height: (mediaQuery.size.height -
          //                       appBar.preferredSize.height -
          //                       mediaQuery.padding.top) *
          //                   0.3,
          //               width: double.infinity,
          //               child: Chart(recentTransaction: _recentTransaction)),
          //           SizedBox(
          //             height: (mediaQuery.size.height -
          //                     appBar.preferredSize.height -
          //                     mediaQuery.padding.top) *
          //                 0.7,
          //             child: TransactionList(
          //               trans: _trans,
          //               deleteTran: _deleteTran,
          //             ),
          //           )
          //         ],
          //       ),
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddTransaction(context),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
