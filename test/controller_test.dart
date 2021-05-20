import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();
  test("GET /gostyle returns 200 a 200 OK", () async {
    final response = await harness.agent.get("/gostyle");
    expectResponse(response, 200, body: isString);
  });

//TEST FOR GUEST CONTROLLER
  test("GET /gostyle/guest/:id returns a single user", () async {
    final response = await harness.agent.get("/gostyle/guest/1");
    expectResponse(response, 200, body: {
      "id": isInteger,
      "username": isString,
    });
  });

  test("POST /gostyle/guest/promo/add add a new promo to user", () async {
    final response =
        await harness.agent.post("/gostyle/guest/promo/add", body: {
      "guest": {"id": 1},
      "promo": {"id": 5}
    });

    expectResponse(response, 200, body: {
      "id": isInteger,
      "guest": {"id": 1},
      "promo": {"id": 5}
    });
  });

  test('DELETE /gostyle/guest/promo/delete/[:idguestpromo] a promo', () async {
    final response =
        await harness.agent.delete('/gostyle/guest/promo/delete/1');
    expectResponse(response, 200, body: 'Deleted 1 items.');
  });

  test('DELETE  returns a 404 response', () async {
    final response =
        await harness.agent.delete('/gostyle/guest/promo/delete/89');
    expectResponse(response, 404, body: 'Item not found.');
  });
}
