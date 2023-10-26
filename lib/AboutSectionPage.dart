import 'package:flutter/material.dart';

class AboutSectionPage extends StatefulWidget {

  @override
  State<AboutSectionPage> createState() => _AboutSectionPageState();
}

class _AboutSectionPageState extends State<AboutSectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        backgroundColor: Color(0xffd2dfff),
        elevation: 0,
        title: Text('About Us',style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/new Updated images/thumbnail_POLITICAL CONSULTING.png',height:350),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Helping Democracy Win:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      leading: Icon(Icons.check),
                      title: Text('Election services from Planning to implementation'),
                    ),
                    ListTile(
                      leading: Icon(Icons.check),
                      title: Text('Researching and Launching campaigns that influence masses'),
                    ),
                    ListTile(
                      leading: Icon(Icons.check),
                      title: Text('In-depth research of political scenario on Macro and Micro level'),
                    ),
                    ListTile(
                      leading: Icon(Icons.check),
                      title: Text('Political evaluation with Technology and reach at ground level'),
                    ),
                    ListTile(
                      leading: Icon(Icons.check),
                      title: Text('Engaging the energy of youth in politics'),
                    ),
                    Text(
                      'How we can help you win elections:',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Our democracy wins, every time a free and fair election is conducted in our country. Another vital aspect is the winning of right candidates who can guide the country on the path of progress.',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Our team of professionals helps you win the elections by planning, organizing and implementing your election campaign in the most effective manner. Strategic management of election starts with segmenting the electorate based on their social, financial, religious and political status. Carrying out thorough research with the help of ground survey, interacting with opinion maker, consultation with leaders from all castes and other methods we try to understand the reasons that will make them prefer one candidate or party over the other. We try to get the pulse of the electorate.',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Center(
                      child: Text(
                        '© 2023 Intellisense Solutions. All Rights Reserved.',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
