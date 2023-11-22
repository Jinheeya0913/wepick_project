import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/layout/default_layout.dart';

enum AgreeStatus { Y, N }

class JoinScreen2 extends ConsumerStatefulWidget {
  static String get routeName => "join2";
  const JoinScreen2({Key? key}) : super(key: key);

  @override
  ConsumerState<JoinScreen2> createState() => _JoinScreen2State();
}

class _JoinScreen2State extends ConsumerState<JoinScreen2> {
  AgreeStatus? _agreeStatus = AgreeStatus.N;
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '회원가입2',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '개인정보 약관동의',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: Text('동의'),
                    value: AgreeStatus.Y,
                    groupValue: _agreeStatus,
                    onChanged: (AgreeStatus? value) {
                      setState(() {
                        _agreeStatus = value;
                        print(_agreeStatus);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text('비동의'),
                    value: AgreeStatus.N,
                    groupValue: _agreeStatus,
                    onChanged: (AgreeStatus? value) {
                      setState(() {
                        _agreeStatus = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {},
              child: const Text('회원가입 2/2'),
            )
          ],
        ),
      ),
    );
  }
}
