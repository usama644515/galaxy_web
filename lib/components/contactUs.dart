import 'package:flutter/material.dart';
import 'package:galaxy_web/components/footer.dart';
import 'package:galaxy_web/components/footer_mobile.dart';
import 'package:galaxy_web/components/side_drawer.dart';
import 'package:galaxy_web/main/home.dart';
import 'package:galaxy_web/responsive.dart';
import 'package:provider/provider.dart';
import '../controllers/MenuController.dart';
import 'mobile_navbar.dart';
import 'navbar.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  Future<bool> onBackPress() async {
    setState(() {
      Provider.of<menuController>(context, listen: false)
          .navmenueSelect('Home');
    });
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Home()),
      (route) => false, // Always return false to remove all routes
    );
    return Future.value(false);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<menuController>(context, listen: false)
        .navmenueSelect('Contact');
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
                    ? MobileNavBar(scaffoldKey, context)
                    : const NavBar(),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Image.network(
            //         'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fbanner.jpg?alt=media&token=ef817b41-1399-4972-993d-63324cc646d0&_gl=1*1n1923a*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5Nzk1OTcxNS40Ni4xLjE2OTc5NjA5MTIuNTEuMC4w',
            //         width: Responsive.isMobile(context)
            //             ? MediaQuery.of(context).size.width * 0.9
            //             : MediaQuery.of(context).size.width * 0.5),
            //   ],
            // ),
            const SizedBox(height: 20),
            Center(
              child: Card(
                elevation: 10.0,
                margin: EdgeInsets.all(16.0),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  width: Responsive.isMobile(context)
                      ? MediaQuery.of(context).size.width * 0.85
                      : MediaQuery.of(context).size.width *
                          0.7, // Adjust the width as needed
                  child: Responsive.isMobile(context)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 15.0,
                            ),
                            Text('Contact Us',
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold)),
                            ImageWidget(),
                            // SizedBox(width: 0.0),
                            ContactForm(),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ContactForm(),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child:
                                  ImageWidget(), // You can replace this with your image widget
                            ),
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),
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

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(
            left: Responsive.isMobile(context) ? 5.0 : 30.0,
            right: Responsive.isMobile(context) ? 5.0 : 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Responsive.isMobile(context)
                ? SizedBox()
                : Text('Contact Us',
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            SizedBox(height: Responsive.isMobile(context) ? 0 : 50.0),
            TextFormField(
              cursorColor: Color(0xffF9A51F),
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(
                  color: Color(0xffF9A51F),
                ),
                filled: true,
                fillColor: Colors.grey[100], // Filled color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0), // Border radius
                  borderSide: BorderSide.none, // No border
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              cursorColor: Color(0xffF9A51F),
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: Color(0xffF9A51F),
                ),
                filled: true,
                fillColor: Colors.grey[100], // Filled color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0), // Border radius
                  borderSide: BorderSide.none, // No border
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                } else if (!RegExp(
                        r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              cursorColor: Color(0xffF9A51F),
              controller: _messageController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Message',
                labelStyle: TextStyle(
                  color: Color(0xffF9A51F),
                ),
                filled: true,
                fillColor: Colors.grey[100], // Filled color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0), // Border radius
                  borderSide: BorderSide.none, // No border
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a message';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            InkWell(
              onTap: () {
                // Handle submit button tap
                if (_formKey.currentState!.validate()) {
                  // Process the form data (e.g., send an email)
                  // You can add your logic here
                  // For now, let's print the data
                  print('Name: ${_nameController.text}');
                  print('Email: ${_emailController.text}');
                  print('Message: ${_messageController.text}');
                }
              },
              onHover: (hover) {
                setState(() {
                  isHovered = hover;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: isHovered
                      ? Color.fromARGB(255, 214, 138, 16)
                      : Color(0xffF9A51F),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isHovered = false;
}

class ImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your image widget or network image
    return Image.network(
      'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/logo%2Fcontact%20us.jpg?alt=media&token=c1e2054a-0c9a-41e8-a857-14e5031f1324',
      fit: BoxFit.cover,
    );
  }
}
