using {
  Currency,
  User,
  managed,
  cuid
} from '@sap/cds/common';
using {sap.changelog.ChangeView} from '@cap-js/change-tracking';

namespace sap.capire.orders;

entity Orders : cuid, managed {
  OrderNo  : String(44) @title: 'Order Number'; //> readable key

  Items    : Composition of many {
               key ID       : UUID;
                   product  : Association to Products;

                   @changelog
                   quantity : Integer;

                   title    : String; //> intentionally replicated as snapshot from product.title

                   @changelog
                   price    : Double; //> materialized calculated field
             };
  buyer    : User;
  currency : Currency;

  changes  : Association to many ChangeView
               on changes.entityKey = ID;

}

/** This is a stand-in for arbitrary ordered Products */
entity Products @(cds.persistence.skip: 'always') {
  key ID : String;
}


// this is to ensure we have filled-in currencies
using from '@capire/common';
