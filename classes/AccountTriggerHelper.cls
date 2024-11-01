public  without sharing  class AccountTriggerHelper {
    Public static void createCase(List<Account> lstAccount){
        try {
        List<Case> lstCase = new List<Case>();
        for(Account acc : lstAccount){
            if(acc.Risk__c =='High'){
              Case objCase = new Case (subject=acc.Name,AccountId=acc.id,Status='New',Origin='Phone');
                lstCase.add(objCase);
            }
        }
        insert lstCase;
        } catch(DmlException e) {
    		System.debug('The following exception has occurred: ' + e.getMessage());
		}
    }
}