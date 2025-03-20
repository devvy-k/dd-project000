
import 'package:devvy_proj/com_module/controller/tableau_controller.dart';
import 'package:devvy_proj/valuation_module/controller/tableau_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
final tabControllerEnjeux = Get.put(TableauController()); 
final tabControllerCom = Get.put(TableauControllerCom());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ElevatedButton(onPressed: () => context.go('/ui-test'), child: Text('Go to Ui test'))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(100, 50, 100, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Material(
                    child: InkWell(
                        child: AnimatedContainer(
                          margin: EdgeInsets.only(right: 20),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          width: 300,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(52, 82, 127, 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Evaluation Graphique enjeux DD',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          context.go("/module-valuation");
                        }
                    ),
                  )
                ),
                Expanded(
                  child: Material(
                    child: InkWell(
                      onTap: (){
                        context.go("/tableau-com");
                      },
                      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: 300,
        height: 150,
        decoration: BoxDecoration(
          color: Color.fromRGBO(46, 55, 70, 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Directives de communication',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      ),
                  )
                )
              ],
            ),
            SizedBox(height: 50),
            Text(
              'Activités recentes',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder(
                      horizontalInside: BorderSide(width: .5, color: Colors.grey),
                    ),
                    children: [
                      TableRow(
                          decoration: BoxDecoration(
                              color: Theme.of(context).secondaryHeaderColor),
                          children: [
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 40,
                                ),
                              ),
                            ),
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'ETUDES',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Text(
                                'Date de creation ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ),
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Text(
                                'Derniere modification',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
