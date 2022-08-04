import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/firestore_service.dart';
import '../../models/match_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MatchHistory extends StatefulWidget {
  @override
  MatchHistoryState createState() => MatchHistoryState();
}

class MatchHistoryState extends State<MatchHistory> {
  final Stream<QuerySnapshot> _matchHistory =
      firestore.getMatchHistory('tabletennis');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _matchHistory,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  Match match = Match.fromJson(data);
                  // return ListTile(
                  //   leading: Text(DateFormat('dd MMM yyyy').format(match.date)),
                  //   subtitle: Text(match.winner.nickname),
                  //   title: Text(match.loser.nickname),
                  // );
                  return Column(
                    children: [
                      RichText(
                        softWrap: true,
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 18.0, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    '${DateFormat('dd MMM yyyy').format(match.date)}\n',
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300)),
                            TextSpan(
                                text: '${match.winner.nickname} (',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: '+${match.winnerDelta}',
                                style: const TextStyle(color: Colors.green)),
                            const TextSpan(
                                text: ')',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const TextSpan(
                                text: ' won against ',
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                                text: '${match.loser.nickname} (',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: '${match.loserDelta}',
                                style: const TextStyle(color: Colors.red)),
                            const TextSpan(
                                text: ')\n',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  );
                })
                .toList()
                .cast(),
          ),
        );
      },
    );
  }
}
