using {sap.capire.bookshop as my} from '../db/schema';

service CatalogService @(path: '/browse') {

  /** For displaying lists of Books */
  @readonly
  entity ListOfBooks        as
    projection on Books
    excluding {
      descr
    };

  entity AllBooksEverywhere as
    projection on my.LibraryBooks {
      key library.displayId as library,
          library.name      as libraryName,
      key book.displayId    as displayId,
          book.title        as title,
          book.author.name  as author,
          stock
    }

  /** For display in details pages */
  entity Books              as
    projection on my.Books {
          createdAt,
          modifiedAt,
          ID,
      key displayId,
          title,
          descr,
          genre,
          price,
          currency,
          image,
          author.name as author
    };

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
