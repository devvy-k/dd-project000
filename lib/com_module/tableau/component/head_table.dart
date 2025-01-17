import 'package:devvy_proj/utils/widgets/head_table_container.dart';
import 'package:flutter/material.dart';

class HeadTable extends StatefulWidget {
  const HeadTable({super.key});

  @override
  State<HeadTable> createState() => _HeadTableState();
}

class _HeadTableState extends State<HeadTable> {

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        color: Colors.blueGrey[700],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            height: 150,
            child: Row(
              children: [
                // Numero
                Expanded(
                  flex: 1,
                  child: HeaderTemplate(title: "Numero"),
                  ),
                // Enjeux
                Expanded(
                  flex: 3,
                  child: HeaderTemplate(title: "Parties prenantes"),
                ),
                Expanded(
                  flex: 1,
                  child: HeaderTemplate(title: "Interet"),
                ),
                Expanded(
                  flex: 1,
                  child: HeaderTemplate(title: "Influence"),
                ),
              ],
            ),
          ),
        ),
      );
  }
}