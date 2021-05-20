import 'dart:core';
import 'package:mobile_app/mobile_app.dart';
import 'package:mobile_app/models/promos.dart';

class Partner extends ManagedObject<_Partner> implements _Partner {}

@Table(name: "partner")
class _Partner {
  @primaryKey
  int id;

  @Column(unique: false)
  String brandName;

  @Column(unique: false)
  String website;

  @Column(unique: false)
  String logo;

  @Column(unique: true)
  String siret;

  ManagedSet<Promo> promos;
}
