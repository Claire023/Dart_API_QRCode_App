import 'package:mobile_app/mobile_app.dart';
import '../models/partner.dart';

// List partners = [];

class PartnerController extends ResourceController {
  PartnerController(this.context);

  ManagedContext context;

  @Operation.get()
  // recupere la liste de tous les qr codes
  Future<Response> getAllPartner() async {
    final partnerQuery = Query<Partner>(context);
    return Response.ok(await partnerQuery.fetch());
  }

  @Operation.get('id')
  //recupere la liste de tous les qr codes
  Future<Response> getPartner(
    @Bind.path('id') int id,
  ) async {
    final partnerQuery = Query<Partner>(context)
      ..where((p) => p.id).equalTo(id);
    final qr = await partnerQuery.fetchOne();

    if (qr == null) {
      return Response.notFound(body: 'item requested not found');
    }
    return Response.ok(qr);
    //This is a comment
  }
}
