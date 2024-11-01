public with sharing  class CountryInformationController {
    
@AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getPicklistValues() {
        List<Schema.PicklistEntry> entries = Country_Information__c.Country__c.getDescribe().getPicklistValues();
        List<Map<String, String>> values = new List<Map<String, String>>();
        for (Schema.PicklistEntry entry : entries) {
            Map<String, String> valueMap = new Map<String, String>();
            valueMap.put('label', entry.getLabel());
            valueMap.put('value', entry.getValue());
            values.add(valueMap);
        }
        return values;
    }
    @AuraEnabled
    public static ResponseWrapper.CountryInformation getCountryInformation(string country, string zipCode) {
        ResponseWrapper.CountryInformation wrappCountry = new ResponseWrapper.CountryInformation();
        try {
            wrappCountry= CountryInformationService.getCountryInformation(country,zipCode);
            if(wrappCountry.countryAbbreviation !='US'){
            	Country_Information__c objCountryInfo = new Country_Information__c();
                objCountryInfo.Country__c=wrappCountry.countryAbbreviation;
                objCountryInfo.Country_Abbreviation__c= wrappCountry.country;
                objCountryInfo.Postal_Code__c=wrappCountry.postCode;
                objCountryInfo.Latitude__c=wrappCountry.places[0].latitude;
                objCountryInfo.Longitude__c=wrappCountry.places[0].longitude;
                objCountryInfo.Place_Name__c=wrappCountry.places[0].placeName;
                objCountryInfo.State__c=wrappCountry.places[0].state;
                objCountryInfo.State_Abbreviation__c=wrappCountry.places[0].stateAbbreviation;
               saveCountryInformation(JSON.Serialize(objCountryInfo));
            }
            return wrappCountry;
        } catch (Exception e) {
             System.debug('Exception:' + e.getMessage());
            return wrappCountry;
        }
    }
    
    @future(callout=true)
    public static void saveCountryInformation(String jsonText) {
        try {
            Country_Information__c objCountryInfo = (Country_Information__c) System.JSON.deserialize(jsonText,Country_Information__c.class );
            	Insert objCountryInfo;
            } catch (DmlException e) {
                System.debug('DML Exception:' + e.getMessage());
			}
            
    }
    @AuraEnabled(cacheable=true)
    public static List<Country_Information__c> getData() {
            return [Select Id,State__c,Country__c,Country_Abbreviation__c,Postal_Code__c,Latitude__c,State_Abbreviation__c,Longitude__c,Place_Name__c from Country_Information__c ];
          }
    
    
}