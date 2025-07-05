public with sharing class ContactTriggerHandler {
<<<<<<< HEAD

public static void handleBeforeInsert(List<Contact> newContact) {
	// When a contact is inserted
	// if DummyJSON_Id__c is null, generate a random number between 0 and 100 and set this as the contact's DummyJSON_Id__c value
	
	Integer randomNum = (Integer)(Math.random() * 100);
    for(Contact cont : newContact) {
        if(cont.DummyJSON_Id__c == null) {
            cont.DummyJSON_Id__c = String.valueOf(randomNum);
        }
	}
}


public static void handleBeforeUpdate(List<Contact> newContact) {
	//When a contact is inserted
	// if DummyJSON_Id__c is less than or equal to 100, call the getDummyJSONUserFromId API
	
	for(Contact cont : newContact) {
		if(Integer.valueOf(cont.DummyJSON_Id__c) <= 100) {
			DummyJSONCallout.getDummyJSONUserFromId(cont.Id);
		}			
	}
}	

public static void handleAfterUpdate(List<Contact> updatedContacts) {
	//When a contact is updated
	// if DummyJSON_Id__c is greater than 100, call the postCreateDummyJSONUser API

	for(Contact cont : updatedContacts) {
		//upsert cont Contact.DummyJSON_Id__c;
		if(Integer.valueOf(cont.DummyJSON_Id__c) >= 100) {
			DummyJSONCallout.postCreateDummyJSONUser(cont.Id);
		}
	}
}
}


/*
public static void handleBeforeInsert(List<Contact> newContact) {
	// When a contact is inserted
	// if DummyJSON_Id__c is null, generate a random number between 0 and 100 and set this as the contact's DummyJSON_Id__c value
	if(Trigger.isBefore && Trigger.isInsert) {
	Integer randomNum = (Integer)(Math.random() * 100);
    for(Contact cont : newContact) {
        if(cont.DummyJSON_Id__c == null) {
            cont.DummyJSON_Id__c = String.valueOf(randomNum);
        }
	}
}
}

public static void handleAfterInsert(List<Contact> newContact) {
	//When a contact is inserted
	// if DummyJSON_Id__c is less than or equal to 100, call the getDummyJSONUserFromId API
	if(Trigger.isAfter && Trigger.isInsert) {
	for(Contact cont : newContact) {
		if(Integer.valueOf(cont.DummyJSON_Id__c) <= 100) {
			DummyJSONCallout.getDummyJSONUserFromId(cont.DummyJSON_Id__c);
		}			
	}
}	
}
public static void handleAfterUpdate(List<Contact> updatedContacts) {
	//When a contact is updated
	// if DummyJSON_Id__c is greater than 100, call the postCreateDummyJSONUser API
	if(Trigger.isBefore && Trigger.isUpdate) {
	for(Contact cont : updatedContacts) {
		if(Integer.valueOf(cont.DummyJSON_Id__c) <= 100) {
			DummyJSONCallout.postCreateDummyJSONUser(cont.Id);
		}
	}
}
}
}
*/
=======
   
    public static void handleBeforeInsert(List<Contact> newContact) {
        // When a contact is inserted
        // if DummyJSON_Id__c is null, generate a random number between 0 and 100 and set this as the contact's DummyJSON_Id__c value
        Integer randomNum = (Integer)(Math.random()*100);
        for(Contact cont : newContact) {
		if(cont.DummyJSON_Id__c != null){
			continue;
		} else {
            cont.DummyJSON_Id__c = String.valueOf(randomNum);
			cont.LeadSource = 'Other';
        }
	}
        for(Contact cont : newContact) {
        if(Integer.valueOf(cont.DummyJSON_Id__c) <= 100 && cont.LeadSource != 'Other') {
			DummyJSONCallout.getDummyJSONUserFromId(cont.DummyJSON_Id__c);
		}
    }
}

   public static void handleAfterUpdate(List<Contact> updatedContacts) {
        //When a contact is updated
	    // if DummyJSON_Id__c is greater than 100, call the postCreateDummyJSONUser API
        for(Contact cont : updatedContacts) {
		if(updatedContacts.size() < 0) {
            continue;
        }else {
            if(Integer.valueOf(cont.DummyJSON_Id__c) >= 100 && cont.LeadSource != 'Other') {
			DummyJSONCallout.postCreateDummyJSONUser(cont.DummyJSON_Id__c);
     }
    }
}
}
}
>>>>>>> e41cc7e012f5a718a7a872e08b7a9583ad11f268
