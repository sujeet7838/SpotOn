import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhaseListCard extends StatelessWidget {
  const PhaseListCard({
    Key? key,
    required this.imageUrl,
    required this.phaseName,
  }) : super(key: key);

  final String imageUrl;
  final String phaseName;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final double fem = screenWidth / 375.0;
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(
          right: 16.0,
        ),
        child: Column(
          children: <Widget>[
            // ListTile(
            //   title:
            Text(
              phaseName,
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 17 * fem,
                fontWeight: FontWeight.w500,
                color: const Color(0xff282828),
                //height: 18 / 15,
              ),
              textAlign: TextAlign.left,
            ),
            //  ),
            // Row(
            //   children: [
            //     Text(
            //       phaseName,
            //       maxLines: 1,
            //       overflow: TextOverflow.ellipsis,
            //       style: Theme.of(context).textTheme.bodyText1?.copyWith(
            //             color: Colors.black,
            //           ),
            //     )
            //   ],
            // ),
            const SizedBox(
              height: 12.0,
            ),
          ],
        ),
      ),
    );
  }
}
