import 'package:flutter/material.dart';
import 'package:galaxy_web/components/side_drawer.dart';
import 'package:galaxy_web/responsive.dart';

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
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          const SizedBox(height: 40),
          Center(
            child: Container(
              width: Responsive.isMobile(context)
                  ? MediaQuery.of(context).size.width * 0.95
                  : MediaQuery.of(context).size.width * 0.7,
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact Us',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _messageController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your message';
                            }
                            return null;
                          },
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: 'Message',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Center(
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) {
                              setState(() {
                                _isHovered = true;
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                _isHovered = false;
                              });
                            },
                            child: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  // You can handle form submission here
                                  String name = _nameController.text;
                                  String email = _emailController.text;
                                  String message = _messageController.text;

                                  // Process the data, e.g., send it to a server

                                  // Reset the form
                                  _nameController.clear();
                                  _emailController.clear();
                                  _messageController.clear();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Message sent successfully!'),
                                    ),
                                  );
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left:Responsive.isMobile(context)? 20: MediaQuery.of(context).size.width *
                                        0.25,
                                    right:Responsive.isMobile(context)? 20: MediaQuery.of(context).size.width *
                                        0.25),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 30),
                                  decoration: BoxDecoration(
                                    color: _isHovered? const Color.fromARGB(255, 180, 138, 70):  const Color(
                                        0xffF9A51F), // Change color on hover
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'SUBMIT',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isHovered = false;
}
