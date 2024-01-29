import 'dart:convert';

import 'package:example/api/firebase_auth.dart';
import 'package:example/class/user_detail_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  late FirebaseAuthentication firebaseAuth;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    firebaseAuth = FirebaseAuthentication(mockHttpClient);
  });

  group('Firebase login,sign in test', () {
    test(
      'login',
      () async {
        when(
          () => mockHttpClient.post(
            Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBr3XfPEXp0hxB1cZRMEnRVWoymaIWm4fw'),
            body: jsonEncode({
              'email': 'test',
              'password': 'test123',
              'returnSecureToken': true,
            }),
            headers: {'Content-Type': 'application/json'},
          ),
        ).thenAnswer(
          (_) async {
            // Mock the response from the HTTP call
            return Response(
              '''
              {
                "kind": "identitytoolkit#VerifyPasswordResponse",
                "localId": "v5KBxRTFuDTv4A3AEXf7xzGyxS42",
                "email": "sats@gg.com",
                "displayName": "nnj",
                "idToken": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjViNjAyZTBjYTFmNDdhOGViZmQxMTYwNGQ5Y2JmMDZmNGQ0NWY4MmIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vcGF0cm9sdGVzdC02M2M3ZCIsImF1ZCI6InBhdHJvbHRlc3QtNjNjN2QiLCJhdXRoX3RpbWUiOjE3MDY0NTkwMjYsInVzZXJfaWQiOiJ2NUtCeFJURnVEVHY0QTNBRVhmN3h6R3l4UzQyIiwic3ViIjoidjVLQnhSVEZ1RFR2NEEzQUVYZjd4ekd5eFM0MiIsImlhdCI6MTcwNjQ1OTAyNiwiZXhwIjoxNzA2NDYyNjI2LCJlbWFpbCI6InNhdHNAZ2cuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbInNhdHNAZ2cuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.b_1ch1RTvtbc_vMVNbzQuYgaoT5cdi-SOTbafCdjMu4LJqLuONfi14a9VLHQlzAmBFc6n4VV2zph3MaRlos67TMtght_t8ILG41YUAVE-T1jCDh6j4WhpszhbK7QfS1tyCOZjZSSyYzm0sIWlsnQVwq2w2ApbqdqXCkGcOV9i_ZWvJAFpYLGN69SnROsJiQbpwdq8Mi10Wh1x7D7yo7gF0dVnhSop9IXVtdALhD6jyChvit8XQgg0Omq962zJ_wOl7PKdShCN4ZUhpVxWb1l-GjJBujg1xBLCrOkBPPLUX6aTgjUg8lohLaEWWt1TSqbqOk9A1PexxZUlPMuQMOwJw",
                "registered": true,
                "refreshToken": "AMf-vBwCuwvV7iQkWmK75ZAhc5zOS2UXWX2KfPOIUuV3c9oyRZZXW3oHGcZersrji79dACm7XBNMB6_lC085M4Fo74DTXyxDLyYk1r3Xj5ZQc2OqWPDV-7S2EjT7vLOW0CzCUQ7VxAIJppKYPrsBZzWQTK2WgwxUb8zDFoYa24KtC3gapY1B3hUmKep3rrGJTVNqabTQkLIy1z_kxo_Ey1GzKPL9Cg372Q",
                "expiresIn": "3600"
              }''',
              200,
            );
          },
        );

        final user = await firebaseAuth.signInWithEmailAndPassword('test', 'test123');
        expect(user, isInstanceOf<UserDetailEntity>());
      },
    );

    test(
      'login failed',
      () async {
        when(
          () => mockHttpClient.post(
            Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBr3XfPEXp0hxB1cZRMEnRVWoymaIWm4fw'),
            body: jsonEncode({
              'email': 'test',
              'password': 'test123',
              'returnSecureToken': true,
            }),
            headers: {'Content-Type': 'application/json'},
          ),
        ).thenAnswer(
          (_) async {
            // Mock the response from the HTTP call
            return Response(
              '''
              {
                "kind": "identitytoolkit#VerifyPasswordResponse",
                "localId": "v5KBxRTFuDTv4A3AEXf7xzGyxS42",
                "email": "sats@gg.com",
                "displayName": "nnj",
                "idToken": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjViNjAyZTBjYTFmNDdhOGViZmQxMTYwNGQ5Y2JmMDZmNGQ0NWY4MmIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vcGF0cm9sdGVzdC02M2M3ZCIsImF1ZCI6InBhdHJvbHRlc3QtNjNjN2QiLCJhdXRoX3RpbWUiOjE3MDY0NTkwMjYsInVzZXJfaWQiOiJ2NUtCeFJURnVEVHY0QTNBRVhmN3h6R3l4UzQyIiwic3ViIjoidjVLQnhSVEZ1RFR2NEEzQUVYZjd4ekd5eFM0MiIsImlhdCI6MTcwNjQ1OTAyNiwiZXhwIjoxNzA2NDYyNjI2LCJlbWFpbCI6InNhdHNAZ2cuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbInNhdHNAZ2cuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.b_1ch1RTvtbc_vMVNbzQuYgaoT5cdi-SOTbafCdjMu4LJqLuONfi14a9VLHQlzAmBFc6n4VV2zph3MaRlos67TMtght_t8ILG41YUAVE-T1jCDh6j4WhpszhbK7QfS1tyCOZjZSSyYzm0sIWlsnQVwq2w2ApbqdqXCkGcOV9i_ZWvJAFpYLGN69SnROsJiQbpwdq8Mi10Wh1x7D7yo7gF0dVnhSop9IXVtdALhD6jyChvit8XQgg0Omq962zJ_wOl7PKdShCN4ZUhpVxWb1l-GjJBujg1xBLCrOkBPPLUX6aTgjUg8lohLaEWWt1TSqbqOk9A1PexxZUlPMuQMOwJw",
                "registered": true,
                "refreshToken": "AMf-vBwCuwvV7iQkWmK75ZAhc5zOS2UXWX2KfPOIUuV3c9oyRZZXW3oHGcZersrji79dACm7XBNMB6_lC085M4Fo74DTXyxDLyYk1r3Xj5ZQc2OqWPDV-7S2EjT7vLOW0CzCUQ7VxAIJppKYPrsBZzWQTK2WgwxUb8zDFoYa24KtC3gapY1B3hUmKep3rrGJTVNqabTQkLIy1z_kxo_Ey1GzKPL9Cg372Q",
                "expiresIn": "3600"
              }''',
              400,
            );
          },
        );

        final user = await firebaseAuth.signInWithEmailAndPassword('test', 'test123');
        expect(user, null);
      },
    );
  });
}
