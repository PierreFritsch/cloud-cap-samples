using {
  Currency,
  managed,
  sap
} from '@sap/cds/common';
using {sap.common.CodeList as CodeList} from '@sap/cds/common';

namespace sap.capire.bookshop;

entity Books : managed {
  key ID         : Integer;
      title      : localized String(111);
      descr      : localized String(1111);
      author     : Association to Authors;
      genre      : Association to Genres;
      stock      : Integer;
      price      : Decimal;
      currency   : Currency;
      image      : LargeBinary @Core.MediaType : 'image/png';
      weight     : Decimal     @Measures.Unit  : weightUnit.code;
      weightUnit : MeasureUnit;
}

type MeasureUnit : Association to one MeasureUnitCode;

entity MeasureUnitCode : CodeList {
      @(
        Common.Text                  : {
          $value                 : name,
          ![@UI.TextArrangement] : #TextOnly
        },
        Common.UnitSpecificScale     : numFractionalDigits,
        Common.UnitSpecificPrecision : significantDecimalDigits
      )
  key code                     : String(3)@(title : '{i18n>UnitOfMeasureCode}');
      numFractionalDigits      : Integer default 0;
      significantDecimalDigits : Integer default 2;
      symbol                   : String(5)@(title : '{i18n>UnitOfMeasureSymbol}');
}

entity Authors : managed {
  key ID           : Integer;
      name         : String(111);
      dateOfBirth  : Date;
      dateOfDeath  : Date;
      placeOfBirth : String;
      placeOfDeath : String;
      books        : Association to many Books
                       on books.author = $self;
}

/**
 * Hierarchically organized Code List for Genres
 */
entity Genres : sap.common.CodeList {
  key ID       : Integer;
      parent   : Association to Genres;
      children : Composition of many Genres
                   on children.parent = $self;
}
