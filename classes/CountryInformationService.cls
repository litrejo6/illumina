public with sharing class CountryInformationService {
 	public static final Integer SUCESS_CODE= 200;
    public static final String SUCCESS = 'Success';
    public static final Integer BAD_REQUEST_ERROR_CODE = 400;
    public static final String BAD_REQUEST_ERROR = 'Bad Request';
    @AuraEnabled(cacheable=true)
    Public static ResponseWrapper.CountryInformation getCountryInformation(string country, string zipCode ){
       ResponseWrapper.CountryInformation respWrapp = new  ResponseWrapper.CountryInformation();
       try{
         String strEndPoint='http://api.zippopotam.us/'+country+'/'+zipCode;
         HTTPClient request = new HTTPClient(strEndPoint,'GET');
         HttpResponse httpResponse =request.getResponse();
            if(httpResponse.getStatusCode()== SUCESS_CODE){
                respWrapp= ResponseWrapper.parse(httpResponse.getBody());
            }else if(httpResponse.getStatusCode()==BAD_REQUEST_ERROR_CODE){
                system.debug(BAD_REQUEST_ERROR); 
            }
            return respWrapp;
        }catch(Exception e){
         system.debug('Error:'+e.getMessage());
         return null;
        }
    }
    
    
    
    

}