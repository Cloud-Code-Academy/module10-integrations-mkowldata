public class ContactHelper {
    public static void handleBeforeInsert(List<Contact> newContacts) {
        // When a contact is inserted
	    // if DummyJSON_Id__c is null, generate a random number between 0 and 100 and set this as the contact's DummyJSON_Id__c value
        for(Contact cont: newContacts) {
            if(cont.DummyJSON_Id__c == null) {
                Integer randomNum = (Integer)(Math.random() * 100);
                cont.DummyJSON_Id__c = String.valueOf(randomNum);
                //System.debug('DummyJSON random no assigned:: ' + cont.DummyJSON_Id__c );
                if(integer.valueOf(cont.DummyJSON_Id__c) <= 100) {
                    DummyJSONCallout.getDummyJSONUserFromId(cont.DummyJSON_Id__c );
                }
            }
        }   
    }

    public static void handleAfterUpdate(List<Contact> updatedContacts) {
        // If a Contact record is updated and the DummyJSON_Id__c value is greater than 100, the trigger initiates the postCreateDummyJSONUser API call. 
        if(System.isFuture()) {
            return;
        }
        for(Contact cont : updatedContacts) {
            if(Integer.valueOf(cont.DummyJSON_Id__c) >= 100) {
                DummyJSONCallout.postCreateDummyJSONUser(cont.Id);    
            }
        }
    }
}