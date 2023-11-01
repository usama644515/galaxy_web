import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_web/responsive.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final TextEditingController orderid = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // if (!Responsive.isDesktop(context))
        //   IconButton(
        //     icon: Icon(Icons.menu,color: Colors.black),
        //     onPressed: context.read<MenuController>().controlMenu,
        //   ),
        // if (!Responsive.isMobile(context))
        const Text(
          "Dashboard",
          style: TextStyle(
              color: Color(0xffF9A51F),
              fontWeight: FontWeight.bold,
              fontSize: 25.0),
        ),

        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),

        // Container(
        //   decoration: BoxDecoration(
        //       color: Colors.white, borderRadius: BorderRadius.circular(10)),
        //   child: Padding(
        //     padding: const EdgeInsets.only(
        //         left: 10.0, right: 10.0, top: 6.0, bottom: 6.0),
        //     child: Row(
        //       children: [
        //         SvgPicture.asset('assets/svg/calender.svg',
        //             color: Color(0xff434C62)),
        //         SizedBox(width: 6.0),
        //         Text('January 31, 2022 — March 1, 2022',
        //             style: TextStyle(color: Color(0xff434C62))),
        //       ],
        //     ),
        //   ),
        // ),
        SizedBox(),
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/profile_pic.png",
            height: 38,
          ),
          if (!Responsive.isMobile(context))
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text("Angelina Jolie"),
            ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
