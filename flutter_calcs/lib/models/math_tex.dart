// import 'package:flutter/material.dart';
// import 'package:flutter_tex/flutter_tex.dart';

// class TexMath {
//   final TeXViewWidget test = r"""
//      When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
//      $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br>""";
//   static TeXViewWidget quadraticEquation =
//       _teXViewWidget(r"<h4>Quadratic Equation</h4>", r"""
//      When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
//      $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br>""");

//   static TeXViewWidget _teXViewWidget(String title, String body) {
//     return TeXViewColumn(
//         style: const TeXViewStyle(
//             margin: TeXViewMargin.all(10),
//             padding: TeXViewPadding.all(10),
//             borderRadius: TeXViewBorderRadius.all(10),
//             border: TeXViewBorder.all(TeXViewBorderDecoration(
//                 borderWidth: 2,
//                 borderStyle: TeXViewBorderStyle.groove,
//                 borderColor: Colors.green))),
//         children: [
//           TeXViewDocument(title,
//               style: const TeXViewStyle(
//                   padding: TeXViewPadding.all(10),
//                   borderRadius: TeXViewBorderRadius.all(10),
//                   textAlign: TeXViewTextAlign.center,
//                   width: 250,
//                   margin: TeXViewMargin.zeroAuto(),
//                   backgroundColor: Colors.green)),
//           TeXViewDocument(body,
//               style: const TeXViewStyle(margin: TeXViewMargin.only(top: 10)))
//         ]);
//   }
// }
