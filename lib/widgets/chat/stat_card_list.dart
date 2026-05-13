import 'package:flutter/material.dart';
import '../../features/chat/data/models/chat_stat.dart';
import 'stat_card.dart';

class StatCardList extends StatelessWidget {
  const StatCardList({super.key, required this.stats});
  
  final List<ChatStat> stats;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: stats
          .map((stat) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: StatCard(stat: stat),
              ))
          .toList(),
    );
  }
}