import 'controllers/guest_controller.dart';
import 'controllers/partner_controller.dart';
import 'controllers/promos_controller.dart';
import 'mobile_app.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class MobileAppChannel extends ApplicationChannel {
  //Connexion a la BDD
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
        'gostyle_user', 'password', 'localhost', 5433, 'gostyle_api');

    context = ManagedContext(dataModel, persistentStore);
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    // Prefer to use `link` instead of `linkFunction`.
    // See: https://aqueduct.io/docs/http/request_controller/
    router.route("/gostyle/guest/[:id]").link(() => GuestController(context));
    router
        .route("/gostyle/partner/[:id]")
        .link(() => PartnerController(context));
    router.route("/gostyle/promo/[:id]").link(() => PromosController(context));
    router.route("/example").linkFunction((request) async {
      return Response.ok({"key": "value"});
    });

    router
        .route("/gostyle/guest/promo/add")
        .link(() => PromosController(context));

    router
        .route("/gostyle/guest/promo/delete/[:idguestpromo]")
        .link(() => PromosController(context));

    router
        .route("/gostyle/guest/promo/[:iduser]")
        .link(() => GuestController(context));

    router
        .route('/gostyle')
        .linkFunction((request) => Response.ok('Hello World !'));

    return router;
  }
}
