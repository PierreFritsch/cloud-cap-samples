using {
  Currency,
  User,
  managed,
  cuid
} from '@sap/cds/common';

namespace sap.capire.orders;

@changelog: [OrderNo]
entity Orders : cuid, managed {
  OrderNo  : String(44) @title: 'Order Number'; //> readable key

  Items    : Composition of many OrderItems
               on Items.parent = $self;
  buyer    : User;
  currency : Currency;
}

entity OrderItems : cuid {
  parent   : Association to Orders;
  product  : Association to Products;

  @changelog
  quantity : Integer;

  title    : String; //> intentionally replicated as snapshot from product.title

  @changelog
  price    : Double; //> materialized calculated field
}

/** This is a stand-in for arbitrary ordered Products */
entity Products @(cds.persistence.skip: 'always') {
  key ID : String;
}


// this is to ensure we have filled-in currencies
using from '@capire/common';
