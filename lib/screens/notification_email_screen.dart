import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationEmailScreen extends StatefulWidget {
  const NotificationEmailScreen({super.key});

  @override
  State<NotificationEmailScreen> createState() =>
      _NotificationEmailScreenState();
}

class _NotificationEmailScreenState extends State<NotificationEmailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff716bc3),
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).padding.top + 6,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                'assets/icons/arrow-left.svg',
                color: Colors.white,
              ),
            ),
          ),
          SizedBox.expand(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Check your email',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Image.asset(
                        'assets/images/email.png',
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                                text:
                                    'We sent an email with your magic link to '),
                            TextSpan(
                              text: 'huyhoang14901@gmail.com',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffffffff),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: size.width * 0.8,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xff726bb8)),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.white60;
                              }
                              return Colors.white;
                            }),
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          onPressed: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => CupertinoActionSheet(
                                actions: [
                                  CupertinoActionSheetAction(
                                    onPressed: () {},
                                    child: const Text('Mail (default)'),
                                  ),
                                  CupertinoActionSheetAction(
                                    onPressed: () {},
                                    child: const Text('Gmail'),
                                  ),
                                  CupertinoActionSheetAction(
                                    onPressed: () {},
                                    child: const Text('Microsoft Outlook'),
                                  ),
                                ],
                                cancelButton: CupertinoActionSheetAction(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                          },
                          child: const Text('Open email'),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
