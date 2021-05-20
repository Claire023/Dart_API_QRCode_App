import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class Migration1 extends Migration {
  @override
  Future upgrade() async {
    database.createTable(SchemaTable("guest", [
      SchemaColumn("id", ManagedPropertyType.bigInteger,
          isPrimaryKey: true,
          autoincrement: true,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("username", ManagedPropertyType.string,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false)
    ]));
    database.createTable(SchemaTable("partner", [
      SchemaColumn("id", ManagedPropertyType.bigInteger,
          isPrimaryKey: true,
          autoincrement: true,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("brandName", ManagedPropertyType.string,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("website", ManagedPropertyType.string,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("logo", ManagedPropertyType.string,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("siret", ManagedPropertyType.string,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: true)
    ]));
    database.createTable(SchemaTable("promos", [
      SchemaColumn("id", ManagedPropertyType.bigInteger,
          isPrimaryKey: true,
          autoincrement: true,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("title", ManagedPropertyType.string,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("description", ManagedPropertyType.string,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("code", ManagedPropertyType.string,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: true),
      SchemaColumn("startPromo", ManagedPropertyType.datetime,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("endPromo", ManagedPropertyType.datetime,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false)
    ]));
    database.createTable(SchemaTable("guestpromos", [
      SchemaColumn("id", ManagedPropertyType.bigInteger,
          isPrimaryKey: true,
          autoincrement: true,
          isIndexed: false,
          isNullable: false,
          isUnique: false)
    ]));
    database.addColumn(
        "promos",
        SchemaColumn.relationship("partner", ManagedPropertyType.bigInteger,
            relatedTableName: "partner",
            relatedColumnName: "id",
            rule: DeleteRule.nullify,
            isNullable: true,
            isUnique: false));
    database.addColumn(
        "guestpromos",
        SchemaColumn.relationship("guest", ManagedPropertyType.bigInteger,
            relatedTableName: "guest",
            relatedColumnName: "id",
            rule: DeleteRule.nullify,
            isNullable: true,
            isUnique: false));
    database.addColumn(
        "guestpromos",
        SchemaColumn.relationship("promo", ManagedPropertyType.bigInteger,
            relatedTableName: "promos",
            relatedColumnName: "id",
            rule: DeleteRule.nullify,
            isNullable: true,
            isUnique: false));
  }

  @override
  Future downgrade() async {}

  @override
  Future seed() async {
    final List<Map> partner = [
      {
        'id': 1,
        'brandName': 'Adidas',
        'website': 'www.adidas.com',
        'logo': 'une image',
        'siret': "12345678922225",
      },
      {
        'id': 2,
        'brandName': 'Nike',
        'website': 'www.nike.com',
        'logo': 'une image2',
        'siret': "12345678922234",
      }
    ];

    final List<Map> guest = [
      {'id': 1, 'username': "François"},
      {'id': 2, 'username': "Françoise"}
    ];

    final List<Map> promos = [
      {
        'id': 1,
        'title': '-50% sur T-Shirt Sportwear',
        'description': 'profitez de notre remise exceptionnelle pour ce mois',
        'code': 'MARS21',
        'startPromo': "2021-07-20",
        'endPromo': "2021-08-01",
        'partner_id': 1,
      },
      {
        'id': 2,
        'title': '-20% sur Sneakers',
        'description': "N'attendez plus pour cette offre exceptionnelle",
        'code': 'SNEAK23K',
        'startPromo': "2021-10-10",
        'endPromo': "2021-11-24",
        'partner_id': 2,
      },
      {
        'id': 3,
        'title': '-30% sur tous les produits energétiques',
        'description': 'Ne rate pas cette offre à durée limité dans notre shop',
        'code': 'NRJ678Q',
        'startPromo': "2021-01-05",
        'endPromo': "2021-02-10",
        'partner_id': 2,
      },
    ];

    for (final pr in partner) {
      await database.store.execute(
          'INSERT INTO partner (id,brandName,website,logo,siret) VALUES (@id,@brandName,@website,@logo,@siret)',
          substitutionValues: {
            'id': pr['id'],
            'brandName': pr['brandName'],
            'website': pr['website'],
            'logo': pr['logo'],
            'siret': pr['siret']
          });
    }

    for (final pm in promos) {
      await database.store.execute(
          'INSERT INTO promos (id,title,description,code,startPromo,endPromo,partner_id) VALUES (@id,@title,@description,@code,@startPromo,@endPromo,@partner_id)',
          substitutionValues: {
            'id': pm['id'],
            'title': pm['title'],
            'description': pm['description'],
            'code': pm['code'],
            'startPromo': pm['startPromo'],
            'endPromo': pm['endPromo'],
            'partner_id': pm['partner_id'],
          });
    }

    for (final gu in guest) {
      await database.store.execute(
          'INSERT INTO guest (id,username) VALUES (@id,@username)',
          substitutionValues: {
            'id': gu['id'],
            'username': gu['username'],
          });
    }
  }
}
