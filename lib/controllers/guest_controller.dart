import 'package:mobile_app/mobile_app.dart';
import 'package:mobile_app/models/guestPromos.dart';
import 'package:mobile_app/models/promos.dart';
import '../models/guest.dart';

List guests = [];

class GuestController extends ResourceController {
  GuestController(this.context);

  ManagedContext context;

//obtenir une promo par id
  @Operation.get('id')
  Future<Response> getPartnerByID(@Bind.path('id') int id) async {
    final promoQuery = Query<Guest>(context)..where((p) => p.id).equalTo(id);

    final promo = await promoQuery.fetchOne();

    if (promo == null) {
      return Response.notFound();
    }
    return Response.ok(promo);
  }

//obtenir les promos par user
  @Operation.get('iduser')
  Future<Response> getPromosByUser(@Bind.path('iduser') int id) async {
    final query = Query<Guest>(context)
      ..where((t) => t.id).equalTo(id)
      ..join(set: (t) => t.guestPromo).join(object: (tp) => tp.promo);
    final data = await query.fetchOne();
    print(data);
    return Response.ok(data);
  }
}
