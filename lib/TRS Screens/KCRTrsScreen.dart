import 'package:flutter/material.dart';

class KCRTrsScreen extends StatefulWidget {
  const KCRTrsScreen({Key? key}) : super(key: key);

  @override
  State<KCRTrsScreen> createState() => _KCRTrsScreenState();
}

class _KCRTrsScreenState extends State<KCRTrsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            ' ',
            style: TextStyle(
              color: Color.fromRGBO(11, 74, 153, 1),
            ),
          ),
        ),
        body: Container(
            child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 10, 7),
                  child: Text(
                    'KCR',
                    style: TextStyle(
                        color: Color.fromRGBO(11, 74, 153, 1),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/Image/KCR-unanimously-re-elected-as-TRS-President.jpg'),
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
                  'Kalvakuntla Chandrashekar Rao (KCR) is the first Chief Minister of Telangana State. He is the founder of the Telangana Rashtra Samithi (TRS Party). KCR played a crucial role in reviving Telangana Statehood movement. Under KCR’s stewardship, the decades-old Telangana statehood demand was achieved in 2014.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
            Padding(
                child: Text(
                  'In 2014 general elections, Telangana Rashtra Samithi, under the leadership of KCR, emerged victorious in 63 of the 119 Assembly seats. TRS Party not only secured the required number of legislators for forming the government but also received the highest vote share. He took oath as the first Chief Minister of the new state of Telangana on 2 June 2014. In 2018 general elections to the Telangana Assembly, KCR led the TRS party to a resounding victory winning 88 out of 119 seats. KCR was sworn in as the Chief Minister of Telangana for a second straight term on 13 December 2018. KCR represents Gajwel constituency of Siddipet district in Telangana state assembly (2014-18, 2018 – 2023). Previously, he served as the MLA from Siddipet ( in erstwhile AP Assembly) and also as the MP from Mahabubnagar, Karimnagar and Medak Parliament constituencies.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
            Padding(
                child: Text(
                  'Early life and family Kalvakuntla Chandrashekhar Rao was born to Sri Raghava Rao and Smt Venkatamma in Chintamadaka village in Medak district (currently in Siddipet district) on 17 February 1954. He married Shobha, daughter of a freedom fighter J.Keshava Rao from Kodurpaaka on 23 April 1969. KCR’s son K. T. Rama Rao is a legislator from Siricilla. KTR is also the Working President of the TRS Party and Minister for IT, MA&UD, Industry, and Commerce. KCR’s daughter Kavitha is in active politics. She is a former Member of Parliament from Nizamabad.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
            Padding(
                child: Text(
                  'Political Career Starting his political journey as a Youth Congress leader in 70s, KCR later joined Telugu Desam Party (TDP) established NT Rama Rao in 1983. Though he lost in 1983 Assembly elections from Siddipet, KCR emerged victorious for four consecutive terms between 1985 and 1999 from the same constituency. In successive TDP governments, KCR worked as Minister of Drought & Relief and Transport Minister. He also served as the Deputy Speaker of the Andhra Pradesh Assembly between 2000 and 2001. Being a staunch supporter of Telangana cause and having fully understood the injustice meted out to Telangana region under Andhra rulers, KCR decided to fight for Telangana statehood. He resigned as the Deputy Speaker of the Andhra Pradesh Assembly and quit the Telugu Desam Party to revive the Telangana movement. He formed Telangana Rashtra Samithi (TRS Party) in April 2001 with the single-point agenda of creating a separate Telangana state with Hyderabad as its capital.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
            Padding(
                child: Text(
                  'With a slogan for self-respect and self-rule, KCR built the TRS Party into a key political force in the region. Every strategy that KCR has adopted as the undisputed leader of TRS party is aimed at achieving the final goal – Telangana Statehood. TRS entered into an alliance with Congress party in 2004 elections when the latter promised to look into Telangana demand. TRS bagged 26 Assembly and five Lok Sabha seats in those elections. TRS was part of the Congress led UPA Government and KCR, the MP from Karimnagar Lok Sabha constituency was initially allotted the Shipping portfolio in the union cabinet. However, another UPA ally DMK party demanded Shipping portfolio and threatened to walk out of the coalition if its demand was not met. KCR voluntarily relinquished the Shipping portfolio to save the fledgling UPA-1 government and remained as a Union Minister without portfolio for a while before being given the portfolio of Labour and Employment. However, he split ways with UPA in protest as the formation of Telangana was delayed. All TRS party MLAs and MPs resigned and went for re elections. In 2009 AP Assembly elections, TRS allied with TDP after TDP agreed to extend its unconditional support to separate Telangana. However, the grand alliance did not yield the desired results as Telangana vote got split between TRS, Congress, PRP and BJP.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
            Padding(
                child: Text(
                  'Fast until death to Realize the Dream KCR intensified the Telangana Movement in the second half the year 2009 with a determination to bring the long struggle for a separate state to its logical conclusion. On 29, 2009, he decided to go on an indefinite hunger strike, a fast until death, demanding that the Congress party introduce Telangana bill in the Parliament. People of Telangana from all walks of life joined hands with KCR. The then government arrested KCR and forcibly shifted him to Khammam jail. KCR’s fast until death culminated in the UPA government at the centre announcing on Dec 9 2009 that the process of statehood for Telangana would be initiated. Soon after the assurance, KCR ended his hunger strike. Undoubtedly, the historic ‘Amarana Deeksha’ that was launched by KCR was the watershed moment of the Telangana statehood movement. However, when Centre backtracked on the statehood issue after a couple of weeks, KCR and TRS party played a pivotal role in the agitation till the Telangana bill was passed in Parliament in February 2014 paving the way for the bifurcation of Andhra Pradesh and creation of Telangana State.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
            Padding(
                child: Text(
                  'A New Beginning Telangana was officially formed on 2 June 2014. Kalvakuntla Chandrashekar Rao became the first Chief Minister of Telangana as the TRS party emerged as the single largest party in the new state Assembly elections held in April-May 2014, winning 63 seats in the 119-member Assembly.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
            Padding(
                child: Text(
                  'Having successfully led the Telangana agitation, KCR has successfully donned the role of an able administrator. Under the leadership of KCR, the government of Telangana is striving towards achieving the people’s dream, a Bangaru Telangana. Kaleswaram Project, Mission Kakatiya, Mission Baghiratha, Rythu Bandhu scheme and Insurance scheme for farmers, KCR Kits, Aasara pension scheme, Kalyana Laxmi, Shaadi Mubarak, KCR Kits, Kanti Velugu, Industrial Policy-TSiPASS are the jewels in KCR’s crown in his four and half year rule as the CM of Telangana. These flagship programmes drew national attention as far as implementation of welfare and developmental programmers is concerned and many other states are emulating KCR by adopting his schemes.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
            Padding(
                child: Text(
                  'KCR, in his second term as the CM of Telangana, has pledged to continue the welfare schemes with renewed vigour and complete the various development schemes kick-started during the previous term.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
            Padding(
                child: Text(
                  'Thanks to the visionary CM KCR, Telangana has become a role model state for the entire country.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
          ],
        )));
  }
}
