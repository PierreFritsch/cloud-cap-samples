using {sap.capire.bookshop as my} from '../db/schema';

service CatalogService @(path: '/browse') {

  /** For displaying lists of Books */
  @readonly
  entity ListOfBooks as
    projection on Books
    excluding {
      descr
    };

  /** For display in details pages */
  @readonly
  entity Books       as
    projection on my.Books {
      ID,
      title,
      price,
      currency,
      genre    : redirected to Genres,
      author.name as author,
      location : redirected to Locations
    };

  entity Genres      as
    projection on my.Genres {
      ID,
      name
    }

  entity Locations   as
    projection on my.Locations {
      ID,
      name
    }

  @requires: 'authenticated-user'
  action submitOrder(book : Books:ID, quantity : Integer) returns {
    stock : Integer
  };

  event OrderedBook : {
    book     : Books:ID;
    quantity : Integer;
    buyer    : String
  };
}
