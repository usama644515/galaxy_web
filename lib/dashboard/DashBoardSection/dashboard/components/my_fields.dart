
import 'package:flutter/material.dart';
import 'package:galaxy_web/dashboard/models/MyFiles.dart';
import 'package:galaxy_web/responsive.dart';

import '../../../constants.dart';
import 'file_info_card.dart';

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 3,
            childAspectRatio:
                _size.width < 650 && _size.width > 350 ? 1.9 : 1.9,
          ),
          tablet:
              FileInfoCardGridView(crossAxisCount: _size.width <= 910? 2 : 3, childAspectRatio: 1.9),
          desktop: FileInfoCardGridView(
            crossAxisCount: _size.width <= 1250 ? 3 : 4,
            childAspectRatio: _size.width < 1400 ? 1.9 : 2,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: demoMyFiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => FileInfoCard(info: demoMyFiles[index]),
    );
  }
}
