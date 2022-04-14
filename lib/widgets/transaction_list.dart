import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(
      {Key? key, required this.trans, required this.deleteTran})
      : super(key: key);

  final List<Transaction> trans;
  final Function deleteTran;

  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return trans.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                const Text('No transaction added yet'),
                SizedBox(height: constraints.maxHeight * 0.05),
                Container(
                  margin: const EdgeInsets.all(10),
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: trans.length,
            itemBuilder: (cxt, index) {
              return Card(
                margin: const EdgeInsets.all(4),
                elevation: 4,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                  text: '\$',
                                  style: TextStyle(
                                    color: Colors.amber,
                                    fontSize: 16,
                                  )),
                              TextSpan(
                                text: trans[index].amount.toString(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(trans[index].title),
                  subtitle: Text(
                    DateFormat.yMMMd().format(trans[index].dateTime),
                  ),
                  trailing: isLandScape
                      ? TextButton(
                          onPressed: () => deleteTran(trans[index].id),
                          child: const Text('Delete'))
                      : IconButton(
                          onPressed: () => deleteTran(trans[index].id),
                          icon: const Icon(Icons.delete),
                        ),
                ),
              );

              // Card(
              //   shadowColor: Colors.black87,
              //   child: Row(
              //     children: [
              //       Container(
              //         decoration: BoxDecoration(
              //             //shape: BoxShape.circle,
              //             border: Border.all(
              //           color: Colors.black,
              //           width: 2,
              //         )),
              //         margin: const EdgeInsets.symmetric(
              //           horizontal: 15,
              //           vertical: 10,
              //         ),
              //         padding: const EdgeInsets.all(5),
              //         child: RichText(
              //           text: TextSpan(children: [
              //             const TextSpan(
              //                 text: '\$ ',
              //                 style: TextStyle(
              //                   color: Colors.amber,
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 20,
              //                 )),
              //             TextSpan(
              //                 text: trans[index].amount.toString(),
              //                 style: const TextStyle(
              //                   color: Colors.black,
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 18,
              //                 ))
              //           ]),
              //           // child: Text('\$' + tran.amount.toString(),
              //           //     style: const TextStyle(
              //           //       fontWeight: FontWeight.bold,
              //           //     )),
              //         ),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(trans[index].title,
              //               style: const TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.bold,
              //               )),
              //           Text(
              //             DateFormat.yMMMd().format(trans[index].dateTime),
              //             style: const TextStyle(
              //               color: Colors.grey,
              //             ),
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              // );
            });
  }
}
