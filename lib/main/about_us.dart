import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_web/components/footer.dart';
import 'package:galaxy_web/components/footer_mobile.dart';
import 'package:galaxy_web/main/bottomBar.dart';
import 'package:galaxy_web/main/home.dart';
import 'package:provider/provider.dart';

import '../components/mobile_navbar.dart';
import '../components/navbar.dart';
import '../components/side_drawer.dart';
import '../components/widgets/teamcard.dart';
import '../controllers/MenuController.dart';
import '../responsive.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Future<bool> onBackPress() async {
    setState(() {
      Provider.of<menuController>(context, listen: false)
          .navmenueSelect('Home');
    });
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => kIsWeb ? Home() : Bar(ind: 0),),
      (route) => false, // Always return false to remove all routes
    );
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        backgroundColor: const Color(0xffF7F7F7),
        key: scaffoldKey,
        drawer: const SideDrawer(),
        body: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(color: Colors.black),
                ),
                Responsive.isMobile(context)
                    ? MobileNavBar(scaffoldKey)
                    : const NavBar(),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Image.network(
            //         'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2FWeb%20Banner.jpg?alt=media&token=bcfc1793-518a-4032-91e8-25a19c9a7cd7&_gl=1*1kwhatu*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzcxNzI3Ny40MS4xLjE2OTc3MTczMjguOS4wLjA.',
            //         width: Responsive.isMobile(context)
            //             ? MediaQuery.of(context).size.width * 0.8
            //             : MediaQuery.of(context).size.width * 0.5),
            //   ],
            // ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(
                  top: 0,
                  left: Responsive.isMobile(context) ? 20 : 50.0,
                  right: Responsive.isMobile(context) ? 20 : 50.0),
              child: Text(
                "About",
                style: TextStyle(
                    fontSize: Responsive.isMobile(context) ? 25.0 : 30.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: Responsive.isMobile(context) ? 20 : 50.0,
                  right: Responsive.isMobile(context)
                      ? 20
                      : MediaQuery.of(context).size.width * 0.4),
              child:  MouseRegion(
                cursor: SystemMouseCursors.text,
                child: Text(
                  "Galaxy Realtor and Builder is a reputable real estate and construction company dedicated to providing innovative and high-quality solutions in the housing and real estate sector. With a commitment to excellence and a customer-centric approach, Galaxy Realtor and Builder has consistently delivered outstanding residential and commercial projects, setting new standards for architectural design, construction, and customer satisfaction. With a team of experienced professionals and a focus on sustainable and eco-friendly development, the company has earned a strong reputation for delivering homes that not only meet the needs of their clients but also reflect the company's vision of creating vibrant, well-planned communities that enhance the quality of life for all residents.",
                  style: TextStyle(fontSize: Responsive.isMobile(context)
                            ? 13: 17.0),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 25.0,
                  left: Responsive.isMobile(context) ? 20 : 50.0,
                  right: Responsive.isMobile(context)
                      ? 20
                      : MediaQuery.of(context).size.width * 0.3),
              child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore
                  .instance //------for select the item in the firestore----
                  .collection('Team')
                  // .where('status', isEqualTo: 'Live')
                  .orderBy('order', descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(top: 20),
                      child: const CircularProgressIndicator(
                          backgroundColor: Colors.grey,
                          color: Color(0xffF9A51F)));
                } else if (snapshot.data!.docs.length == 0) {
                  return Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(top: 20),
                      child: const Text('No Data Found'));
                } else {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: Responsive.isMobile(context)
                          ? 0.8
                          : 1.0, 
                  crossAxisCount:
                    Responsive.isMobile(context)
                          ?2:  3, // You can adjust the number of columns as needed
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data!.docs[index];
                  return TeamCard(
                    teamMember: data,
                  );
                },
              );
                }
              },
            ),
            ),
            Responsive.isMobile(context)
                ? const FooterMobile()
                : const Footer(),
          ],
        ),
      ),
    );
  }

  bool _isHovered = false;
}
