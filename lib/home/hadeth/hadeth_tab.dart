import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_islami_c9_mon/home/hadeth/item_hadeth_name.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HadethTab extends StatefulWidget {
  @override
  State<HadethTab> createState() => _HadethTabState();
}

class _HadethTabState extends State<HadethTab> {
  List <Hadeth> hadethList = [];

  @override
  Widget build(BuildContext context) {
    if (hadethList.isEmpty) {
      loadHadethFile();
    }
    return Column(
      children: [
        Center(child: Image.asset('assets/images/hadeth_logo.png')),
        Divider(
          color: Theme
              .of(context)
              .primaryColor,
          thickness: 3,
        ),
        Text(
          AppLocalizations.of(context)!.hadeth_name,
          style: Theme
              .of(context)
              .textTheme
              .titleMedium,
        ),
        Divider(
          color: Theme
              .of(context)
              .primaryColor,
          thickness: 3,
        ),
        hadethList.isEmpty ?
        Center(child: CircularProgressIndicator(
          color: Theme
              .of(context)
              .primaryColor,
        ))
            :
        Expanded(
          child: ListView.separated(
            separatorBuilder: ((context, index) {
              return Divider(
                color: Theme
                    .of(context)
                    .primaryColor,
                thickness: 2,
              );
            }),
            itemBuilder: (context, index) {
              return ItemHadethName(hadeth: hadethList[index]);
            },
            itemCount: hadethList.length,
          ),
        )
      ],
    );
  }

  void loadHadethFile() async {
    String ahadethContent = await rootBundle.loadString(
        'assets/files/ahadeth.txt');
    List<String> ahadethList = ahadethContent.split('#\r\n');

    /// edit
    for (int i = 0; i < ahadethList.length; i++) {
      print(ahadethList[i]);
      print('---------------------------');
      List<String> ahadethLines = ahadethList[i].split('\n');
      String title = ahadethLines[0];
      ahadethLines.removeAt(0);
      Hadeth hadeth = Hadeth(title: title, content: ahadethLines);
      hadethList.add(hadeth);
      setState(() {

      });
    }
  }
}

/// data class
class Hadeth {
  String title;

  List<String> content;

  Hadeth({required this.title, required this.content});
}
