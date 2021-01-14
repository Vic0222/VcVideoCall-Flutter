import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vc_video_call/components/contact_card.dart';
import 'package:vc_video_call/components/default_circle_avatar.dart';
import 'package:vc_video_call/grpc/generated/chat.pbgrpc.dart';

void main() {
  testWidgets('Contact card displays name and image',
      (WidgetTester tester) async {
    var fakeRoom = Room();
    fakeRoom.name = "Test Name";
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child: Material(
        child: MediaQuery(
          data: new MediaQueryData(),
          child: ContactCard(fakeRoom),
        ),
      ),
    ));

    // Verify that the name exist
    expect(find.text('Test Name'), findsOneWidget);
    expect(find.byType(DefaultCircleAvatar), findsOneWidget);
  });
}
