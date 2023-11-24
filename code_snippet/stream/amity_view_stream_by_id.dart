import 'package:flutter/material.dart';
  /* begin_sample_code
    gist_id: 4be4a38a2aa2b35710ce9fc38682b6aa
    filename: AmityViewStreamById.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter View Stream by Stream Id
    */

  

// class ViewStream extends StatefulWidget {
//   final AmityStream stream;
//   const ViewStream({super.key, required this.stream});

//   @override
//   State<ViewStream> createState() => _ViewStreamState();
// }

// class _ViewStreamState extends State<ViewStream> {

//   late AmityVideoContoller controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = AmityVideoContoller(streamId: widget.stream.streamId!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AmityVideoPlayer(
//         controller: controller,
//         onStop: () {
//           GoRouter.of(context).pop();
//         },
//       ),
//     );
//   }
// }
/* end_sample_code */