import 'package:mobile_app/mobile_app.dart';
import 'guestPromos.dart';

class Guest extends ManagedObject<_Guest> implements _Guest {}

@Table(name: "guest")
class _Guest {
  @primaryKey
  int id;

  @Column(unique: false)
  String username;

  ManagedSet<GuestPromo> guestPromo;
}
