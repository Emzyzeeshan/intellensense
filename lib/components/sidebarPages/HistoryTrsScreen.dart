import 'package:flutter/material.dart';

import '../../TRS Screens/KCRTrsScreen.dart';
import '../../TRS Screens/MLAsTrsScreen.dart';

class HistoryTrsScreen extends StatefulWidget {
  dynamic Function(BuildContext)? leader;
  HistoryTrsScreen({Key? key, this.leader}) : super(key: key);

  @override
  State<HistoryTrsScreen> createState() => _HistoryTrsScreenState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _HistoryTrsScreenState extends State<HistoryTrsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        /*actions: <Widget>[
          Container(
            width: 60,
            child: CircleAvatar(
              backgroundImage:
                  AssetImage('assets/Image/trs-party-logo-medium.jpg'),
            ),
          )
        ],*/
        /*flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.pink, Colors.black38]),
          ),
        ),*/
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => KCRTrsScreen()));
            },
            child: Icon(Icons.arrow_back_ios_new_rounded)),
        backgroundColor: Color.fromRGBO(11, 74, 153, 1),
        title: Text("History of TRS"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: "History",
            ),
            Tab(
              text: "TimeLine",
            ),
            Tab(
              text: "LeaderShip",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          HistoryList(),
          TimeLineList(),
          LeaderShipList(context),
        ],
      ),
    );
  }
}

HistoryList() {
  return ListView(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 10, 7),
            child: Text(
              'History',
              style: TextStyle(
                  color: Color.fromRGBO(11, 74, 153, 1),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          CircleAvatar(
            backgroundImage:
                AssetImage('assets/Image/trs-party-logo-medium.jpg'),
            radius: 30,
          ),
        ],
      ),
      const Divider(
        color: Color.fromRGBO(11, 74, 153, 1),
        height: 5,
        thickness: 2,
        indent: 10,
        endIndent: 10,
      ),
      Padding(
          child: Text(
            'Telangana Rashtra Samithi, popularly known as TRS party, was founded on 27th April 2001 by Kalvakuntla Chandrashekar Rao (KCR). The one and only objective of TRS Party then was to achieve a separate statehood to Telangana. With its uncompromising spirit to make aspirations for Telangana a reality, TRS Party played a pivotal role in carrying forth a sustained agitation to achieve statehood for Telangana.',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
      Padding(
          child: Text(
            'Background to Telangana Statehood Struggle:',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color.fromRGBO(11, 74, 153, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              //backgroundColor: Color.fromRGBO(11, 74, 153, 1),
            ),
          ),
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
      Padding(
          child: Text(
            'Telangana statehood struggle is one of the longest peoples’ movements in the world. The six decade struggle, which began in early 50s, has reached its goal in February 2014. ',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
      Padding(
          child: Text(
            'The first statehood movement of 1950s led to the States Reorganization Commission recommending the Telangana state (then called Hyderabad State) in 1955 itself. But intense lobbying by Seemandhra political leaders resulted in Telangana being forcibly merged with Andhra state to form Andhra Pradesh state in November 1956.',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
      Padding(
          child: Text(
            'Telangana leaders, who suspected that Andhra region would dominate Telangana in all aspects, insisted that certain guarantees be given to Telangana before merger. Thus a “Gentleman’s Agreement” with safeguards to Telangana region was signed by leaders of both the regions.',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
      Padding(
          child: Text(
            'But, even before the ink on the Gentleman’s Agreement dried up, Andhra leaders flouted all safeguards and broke all promises made to Telangana region. Telangana was discriminated in budgetary allocations. Jobs and educational opportunities belonging to Telangana region were usurped by Andhras.',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
      Padding(
          child: Text(
            'Students and employees of the region rose up in an agitation demanding separate Telangana state in 1969. However, this movement for statehood was suppressed by the state and central governments. About 370 youngsters were brutally gunned down by the police.',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
      Padding(
          child: Text(
            'In May 1971, Telangana Praja Samithi Party headed by Marri Chenna Reddy won 10 of the 14 Parliament seats in Telangana region. But, very soon, Chenna Reddy merged Telangana Praja Samithi with Congress party.',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
      Padding(
          child: Text(
            'TRS takes up the struggle:',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color.fromRGBO(11, 74, 153, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              //backgroundColor: Color.fromRGBO(11, 74, 153, 1),
            ),
          ),
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
      Padding(
          child: Text(
            'While the statehood aspirations were alive in people, it took sometime before they found the right platform to intensify the agitation. In mid 90s, several peoples’ organizations started conducting meetings and seminars on the Telangana statehood issue.',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
      Padding(
          child: Text(
            'Kalvakuntla Chandrashekar Rao (KCR), who was then the Deputy Speaker of Andhra Pradesh State assembly, had started background work on Telangana issue in early 2000. And after detailed discussions and deliberations with many Telangana intellectuals, KCR  had resigned to the posts of Deputy Speaker and MLA and announced the launch of Telangana Rashtra Samithi Party on 27th April 2001. Prof Jayashankar, the ideologue of Telangana statehood movement extended his support to KCR.',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
      Padding(
          child: Text(
            'In 2004, TRS entered into a poll alliance with Congress party. The TRS party won 26 MLAs and 5 MPs and entered both the AP state Assembly and Indian Parliament. Telangana issue found a place in UPA-1 Common Minimum Program. The issue was also mentioned by President Abdul Kalam and Prime Minister Manmohan Singh in their respective speeches in the parliament.',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
      Padding(
          child: Text(
            'TRS president KCR was initially allotted the Shipping portfolio in union cabinet. However, another UPA ally DMK party demanded Shipping portfolio and threatened to walk out of the coalition if its demand was not met. KCR voluntarily relinquished the Shipping portfolio to save the fledgling UPA-1 government. KCR remained as a Union Minister without portfolio for a while before being given the portfolio of Labour and Employment.',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
      Padding(
          child: Text(
            'As the UPA government did not show any serious interest in respecting the decades old demand for Telangana state, KCR resigned to his ministry in 2006. When a Congress leader made a belittling statement on the statehood movement in September 2006, KCR resigned to the Karimnagar Lok Sabha seat and won it again with a thumping majority. The massive majority achieved by KCR in that election proved the strong statehood aspirations in the region.',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
      Padding(
          child: Text(
            'YS Rajasekhar Reddy, who was then the Chief Minister of Andhra Pradesh used all kinds of illegal inducements to split the TRS party. A few MLAs left the party during this time. Despite many odds and political setbacks, TRS continued its struggle. In April 2008, TRS party MLAs resigned and also walked out of the state government in protest against the inordinate delay in Telangana formation. But, TRS could retain only 7 MLA and 2 Lok Sabha seats in this by-election.',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
      Padding(
          child: Text(
            'In 2009 elections, TRS allied with TDP after TDP agreed to extend its unconditional support to separate Telangana. However, the grand alliance did not yield the desired results as Telangana vote got split between TRS, Congress, PRP and BJP. In the end, TRS could win only 10 MLA seats and 2 MP seats.',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
      Padding(
          child: Text(
            'Intensifying the movement and realizing the dream:',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color.fromRGBO(11, 74, 153, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              //backgroundColor: Color.fromRGBO(11, 74, 153, 1),
            ),
          ),
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
      Padding(
          child: Text(
            'On Nov 29th, 2009 , KCR had announced an indefinite hunger strike demanding statehood to Telangana. But enroute, the state police had arrested and sent him to Khammam sub-jail. The movement spread like wildfire with students, employees, peoples’ organizations plunging into it. In the next 10 days, the whole of Telangana region came to a standstill. The state government had called for an all-party meeting on 7th December. Leaders of TDP and PRP parties promised that they would support a Telangana statehood resolution if it was tabled in the state Assembly. ',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
      Padding(
          child: Text(
            'As KCR’s health was deteriorating very fast, the UPA government,on Dec 9th 2009, announced that the process of statehood for Telangana would be initiated.',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
      Padding(
          child: Text(
            'But within 2 weeks, Seemandhra lobby succeeded in making the UPA backtrack on this issue. KCR then brought all political forces in Telangana region together to form the Telangana JAC – an umbrella body of several organizations and parties, with Prof Kodandaram as its Chairman. TRS cadre and leaders actively participated in several agitations and protests launched by TJAC.',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
      Padding(
          child: Text(
            'After 4 years of peaceful and powerful protests, the UPA government started the statehood process in July 2013 and concluded the process by passing the statehood bill in both houses of Parliament in Feb 2014.',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
      Padding(
          child: Text(
            'Telangana Self Rule:',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color.fromRGBO(11, 74, 153, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              //backgroundColor: Color.fromRGBO(11, 74, 153, 1),
            ),
          ),
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
      Padding(
          child: Text(
            'The TRS party emerged as the single largest party in the new state assembly elections held in April-May 2014, winning 63 seats in the 119-member assembly, TRS supremo Kalvakuntla Chandrasekhar Rao took the mantle of the Chief Minister of Telangana with a pledge to make Telangana “Bangaru Telangana” and a role model state in India. ',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
      Padding(
          child: Text(
            'TRS formed its second successive government in Telangana with a thumping majority by winning in 88 seats. People of Telangana gave their mandate to TRS after witnessing great development in the state in the first four-and-a-half years.  The welfare schemes and development programs introduced by TRS government under the visionary leadership of CM Shri KCR helped the party in registering a resounding victory.',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
    ],
  );
}

TimeLineList() {
  return ListView(children: [
    Text(
      'Main events in the history of TRS',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 20, color: Color.fromRGBO(11, 74, 153, 1), fontWeight: FontWeight.bold),
    ),
    Padding(padding: EdgeInsets.all(10.0)),
    ListTile(
      title: Column(
        children: [
          Container(
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    width: 50,
                    alignment: Alignment.center,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                              width: 5,
                              color: Colors.blue,
                              style: BorderStyle.solid)),
                    ),
                  ),
                  Text(
                    '27-04-2001',
                    style: TextStyle(color: Color.fromRGBO(11, 74, 153, 1),),
                  )
                ],
              )),
          Container(
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 50,
                    alignment: Alignment.center,
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              color: Colors.grey,
                              width: 3,
                              height: 100 // if I remove the size it desappear
                              ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Text(
                              'TRS announced at Jaladrushyam, Hyderabad (KCR resigned his Deputy Speaker, MLA and Telugu Desam Party memebership)'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    width: 50,
                    alignment: Alignment.center,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                              width: 5,
                              color: Colors.blue,
                              style: BorderStyle.solid)),
                    ),
                  ),
                  Text(
                    '17-05-2001',
                    style: TextStyle(color: Color.fromRGBO(11, 74, 153, 1),),
                  )
                ],
              )),
          Container(
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 50,
                    alignment: Alignment.center,
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              color: Colors.grey,
                              width: 3,
                              height: 100 // if I remove the size it desappear
                              ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Text(
                              '“Simha Garjana” Public Meeting at Karimnagar is a Grand Success.)'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    width: 50,
                    alignment: Alignment.center,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                              width: 5,
                              color: Colors.blue,
                              style: BorderStyle.solid)),
                    ),
                  ),
                  Text(
                    '01-06-2001',
                    style: TextStyle(color: Color.fromRGBO(11, 74, 153, 1),),
                  )
                ],
              )),
          Container(
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 50,
                    alignment: Alignment.center,
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              color: Colors.grey,
                              width: 3,
                              height: 100 // if I remove the size it desappear
                              ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Text('Public meeting at ‘Mahabubnagar’.'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    width: 50,
                    alignment: Alignment.center,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                              width: 5,
                              color: Colors.blue,
                              style: BorderStyle.solid)),
                    ),
                  ),
                  Text(
                    '02-06-2001 ',
                    style: TextStyle(color: Color.fromRGBO(11, 74, 153, 1),),
                  )
                ],
              )),
          Container(
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 50,
                    alignment: Alignment.center,
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              color: Colors.grey,
                              width: 3,
                              height: 100 // if I remove the size it desappear
                              ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Text(
                            'Public meeting at ‘ Nalgonda’.',
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    )
  ]);
}

LeaderShipList(BuildContext context) {
  return ListView(children: <Widget>[
    Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
        child: Card(
          elevation: 12,
          color: Colors.white,
          child: ListTile(
            leading: Container(
              child: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/Image/KCR-unanimously-re-elected-as-TRS-President.jpg'),
                radius: 25,
              ),
            ),
            title: Text('Sri Kalvakuntla Chandrashekar Rao'),
            subtitle: Text('KCR'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.lightBlueAccent,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => KCRTrsScreen()));
            },
          ),
        ),
      ),
    ),
    /*Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
        child: Card(
          elevation: 12,
          color: Colors.white,
          child: ListTile(
            leading: Container(
              child: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/Image/Government_of_Telangana_Logo.png'),
                radius: 25,
              ),
            ),
            title: Text('MPs'),
            subtitle: Text('MP’s Loksabha'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.lightBlueAccent,
            ),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MPsTrsScreen()));
            },
          ),
        ),
      ),
    ),*/
    Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
        child: Card(
          elevation: 12,
          color: Colors.white,
          child: ListTile(
            leading: Container(
              child: CircleAvatar(
                backgroundImage:
                    AssetImage('assets/Image/Government_of_Telangana_Logo.png'),
                radius: 25,
              ),
            ),
            title: Text('MLAs & MLCs'),
            subtitle: Text(''),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.lightBlueAccent,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MLAsTrsScreen()));
            },
          ),
        ),
      ),
    ),
  ]);
}
