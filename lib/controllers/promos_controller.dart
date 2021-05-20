import 'package:mobile_app/mobile_app.dart';
import 'package:mobile_app/models/guest.dart';
import 'package:mobile_app/models/guestPromos.dart';
import '../models/promos.dart';

List promos = [];

class PromosController extends ResourceController {
  PromosController(this.context);

  final ManagedContext context;

  @Operation.get()
  // recupere la liste de tous les qr codes
  Future<Response> getAllPromos() async {
    final readQuery = Query<Promo>(context);
    return Response.ok(await readQuery.fetch());
  }

  //obtenir une promo par id
  @Operation.get('id')
  Future<Response> getPromosByID(@Bind.path('id') int id) async {
    final promoQuery = Query<Promo>(context)..where((p) => p.id).equalTo(id);

    final promo = await promoQuery.fetchOne();

    if (promo == null) {
      return Response.notFound();
    }
    return Response.ok(promo);
  }

  @Operation.post()
  Future<Response> addPromoByUser(@Bind.body() GuestPromo guestPromo) async {
    final query = Query<GuestPromo>(context)..values = guestPromo;
    final insertedPost = await query.insert();
    return Response.ok(insertedPost);
  }

  //delete promo by user
  @Operation.delete('idguestpromo')
  Future<Response> deletePromosByUser(@Bind.path('idguestpromo') int id) async {
    final query = Query<GuestPromo>(context)..where((t) => t.id).equalTo(id);
    final deletedPost = await query.delete();
    if (deletedPost > 0) {
      return Response.ok('promo supprimée avec succès');
    }
    return Response.notFound();
  }
}
