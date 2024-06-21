using CatalogService from '@capire/bookstore';

////////////////////////////////////////////////////////////////////////////
//
//	Books Object Page
//
annotate CatalogService.Books with @(UI: {
    HeaderInfo       : {
        TypeName      : 'Book',
        TypeNamePlural: 'Books',
        Description   : {Value: author}
    },
    HeaderFacets     : [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>Description}',
        Target: '@UI.FieldGroup#Descr'
    }, ],
    Facets           : [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>Details}',
        Target: '@UI.FieldGroup#Price'
    }, ],
    FieldGroup #Descr: {Data: [{Value: descr}, ]},
    FieldGroup #Price: {Data: [
        {Value: price},
        {
            Value: currency.symbol,
            Label: '{i18n>Currency}'
        },
    ]},
});


////////////////////////////////////////////////////////////////////////////
//
//	Books List Page
//
annotate CatalogService.Books with @(UI: {
    PresentationVariant: {
        $Type         : 'UI.PresentationVariantType',
        Text          : 'Default',
        Visualizations: ['@UI.LineItem'],
        SortOrder     : [{Property: location.ID}],
        GroupBy       : [
            location.ID,
            location.name
        ],
    },
    SelectionFields    : [
        ID,
        price,
        currency_code
    ],
    LineItem           : [
        {
            Value: ID,
            Label: '{i18n>Title}'
        },
        {
            Value        : location_ID,
            ![@UI.Hidden]: true
        },
        {Value: location.name},
        {Value: location.ID},
        {
            Value: author,
            Label: '{i18n>Author}'
        },
        {Value: genre.name},
        {Value: price},
        {Value: currency.symbol},
    ]
}, );
