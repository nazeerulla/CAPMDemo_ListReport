using sap.capire.listReport from '../db/schema';

service CatalogService {
    entity Products as projection on listReport.Products;
    entity Suppliers as projection on listReport.Suppliers;
    //entity Currencies as projection on listReport.Currencies;
};

annotate CatalogService.Suppliers with @(
    UI: {
      HeaderInfo: {
        TypeName: '{i18n>Cat.TypeName}',
        TypeNamePlural: '{i18n>Cat.TypeNamePlural}',
        Title: { $Type: 'UI.DataField', Value: name }
      },    
      SelectionFields: [ identifier, country, city],      
      LineItem: [
     //   {$Type: 'UI.DataField', Value: image_url},
        {$Type: 'UI.DataField', Value: identifier},
     
        {$Type: 'UI.DataField', Value: country},
        {$Type: 'UI.DataField', Value: city}

       
      ],
      HeaderFacets: [       
        {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#ProductDetail', Label:'{i18n>Cat.HeaderFacetDetails}' },
        {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#SupplierDetail', Label:'{i18n>Cat.HeaderFacetSupplier}' },
        {$Type: 'UI.ReferenceFacet', Target: '@UI.DataPoint#Price'}
      ],

        FieldGroup#ProductDetail: {
        Data:[
          {$Type: 'UI.DataField', Value: country},
          {$Type: 'UI.DataField', Value: city}
        ]
      },
      FieldGroup#SupplierDetail: {
        Data:[
          {$Type: 'UI.DataField', Value: identifier},
          {$Type: 'UI.DataField', Value: postCode},
          {$Type: 'UI.DataField', Value: phone}
        ]
      },
      DataPoint#Price: {Value: country, Title: '{i18n>Cat.HeaderPrice}'},

       Facets: [
        {
          $Type: 'UI.CollectionFacet',
          Label: '{i18n>Cat.FacetProductInformation}',
          Facets: [
            {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#Description', Label: '{i18n>Cat.FacetSectionDescription}'},
             {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#Items', Label:'{i18n>Cat.Items}' },
          ]
        },

         {
            $Type         : 'UI.ReferenceFacet',
            Label         : '{i18n>IncidentProcessFlow}',
            ID            : 'ProcessFlowFacet',
            Target        : 'products/@UI.LineItem',
           
           
        },
        

        
      ],
      
      FieldGroup#Description: {
        Data:[
            {$Type: 'UI.DataField', Value: city}
        ]
      },
       FieldGroup#Items: {
        Data:[
            {$Type: 'UI.DataField', Value: country}
        ]
      } 
    
    }
);

annotate CatalogService.Products with {
  ID @( Common: { Label: '{i18n>Cat.ProductID}'} );
  availability @( Common.Label: '{i18n>Cat.ProductStock}' );
  price @( Common.Label: '{i18n>Cat.ProductPrice}', Measures.ISOCurrency: currency_code );
  description @( Common.Label: '{i18n>Cat.ProductDescr}' );
 // image_url @( Common.Label: '{i18n>Cat.ProductImage}', UI.IsImageURL: true);
}

annotate CatalogService.Products with @(UI : {
    LineItem : [
        //insert your column enhancement here
        
        {
            $Type : 'UI.DataField',
            Value : identifier
        },
        {
            $Type : 'UI.DataField',
            Value : title
        },
        {
            $Type : 'UI.DataField',
            Value : availability
        },
        {
            $Type : 'UI.DataField',
            Value : price
        }
    ]
});



