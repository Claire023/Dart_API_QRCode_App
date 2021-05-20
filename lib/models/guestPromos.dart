import 'dart:core';
import 'package:mobile_app/mobile_app.dart';
import 'package:mobile_app/models/promos.dart';

import 'guest.dart';

class GuestPromo extends ManagedObject<_GuestPromo> implements _GuestPromo {}

@Table(name: "guestpromos")
class _GuestPromo {
  @primaryKey
  int id;

  @Relate(#guestPromo)
  Guest guest;

  @Relate(#guestPromo)
  Promo promo;
}
