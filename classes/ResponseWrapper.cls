Public with sharing class ResponseWrapper {
    
     Public class CountryInformation{
       @AuraEnabled public String postCode { get; set; }
       @AuraEnabled public String country { get; set; }
       @AuraEnabled public String countryAbbreviation { get; set; }
       @AuraEnabled public List<Place> places { get; set; }
    }
     Public class Place{
        @AuraEnabled  public String placeName { get; set; }
        @AuraEnabled public String longitude { get; set; }
        @AuraEnabled  public String state { get; set; }
        @AuraEnabled public String stateAbbreviation { get; set; }
        @AuraEnabled public String latitude { get; set; }
    }
    
     public static CountryInformation parse(String json){
         json = json.replaceAll('country abbreviation','countryAbbreviation')
                    .replaceAll('place name', 'placeName')
             		.replaceAll('post code', 'postCode')
                    .replaceAll('"state abbreviation":', '"stateAbbreviation":');
        return (CountryInformation) System.JSON.deserialize(json, CountryInformation.class);
    }
    
}