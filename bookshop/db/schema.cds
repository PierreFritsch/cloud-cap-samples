using {
  Currency,
  managed,
  sap
} from '@sap/cds/common';

namespace sap.capire.bookshop;

entity Libraries : managed {
  key ID        : Integer;
      displayId : String(20)  @mandatory;
      name      : String(111) @mandatory;
      books     : Association to many LibraryBooks
                    on books.library = $self;
}

@assert.unique: {libraryBook: [
  library,
  book
]}
entity LibraryBooks : managed {
  key ID      : Integer;
      library : Association to Libraries;
      book    : Association to Books;
      stock   : Integer;
}

@assert.unique: {displayId: [displayId]}
entity Books : managed {
  key ID        : Integer;
      displayId : String(20)             @mandatory;
      title     : localized String(111)  @mandatory;
      descr     : localized String(1111);
      author    : Association to Authors @mandatory;
      genre     : Association to Genres;
      stock     : Integer;
      price     : Decimal;
      currency  : Currency;
      image     : LargeBinary            @Core.MediaType: 'image/png';
}

entity Authors : managed {
  key ID           : Integer;
      name         : String(111) @mandatory;
      dateOfBirth  : Date;
      dateOfDeath  : Date;
      placeOfBirth : String;
      placeOfDeath : String;
      books        : Association to many Books
                       on books.author = $self;
}

/** Hierarchically organized Code List for Genres */
entity Genres : sap.common.CodeList {
  key ID       : Integer;
      parent   : Association to Genres;
      children : Composition of many Genres
                   on children.parent = $self;
}
