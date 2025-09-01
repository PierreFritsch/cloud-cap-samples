using {sap.capire.orders as my} from '../db/schema';

service OrdersService {

  @cds.redirection.target
  entity Orders        as
    projection on my.Orders {
      ID,

      createdAt,
      createdBy,
      modifiedAt,
      modifiedBy,

      OrderNo,
      Items : redirected to OrderItems,
      buyer,
      currency
    }

  entity OrderItems    as
    projection on my.OrderItems {
      *
    }

  @odata.draft.bypass
  @(requires: 'system-user')
  entity OrdersNoDraft as projection on my.Orders;

  event OrderChanged {
    product       : String;
    deltaQuantity : Integer;
  }

}
