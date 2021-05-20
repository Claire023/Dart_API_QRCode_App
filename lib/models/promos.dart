import 'dart:core';

import 'package:mobile_app/mobile_app.dart';
import 'package:mobile_app/models/guestPromos.dart';
import '../models/partner.dart';

class Promo extends ManagedObject<_Promo> implements _Promo {}

@Table(name: "promos")
class _Promo {
  @primaryKey
  int id;

  @Column(unique: false)
  String title;

  @Column(unique: false)
  String description;

  @Column(unique: true)
  String code;

  @Column(unique: false)
  DateTime startPromo;

  @Column(unique: false)
  DateTime endPromo;

  @Relate(#promos)
  // String partner_id_siret_fk;
  Partner partner;

  ManagedSet<GuestPromo> guestPromo;
}
