global class EmailtoCO implements Messaging.InboundEmailHandler {
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, 
                                                         Messaging.Inboundenvelope envelope) {
  
Madrid__c  madrid;
Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();

try {

// Look for customobject  whose name is the subject and create it if necessary
if ([select count() from Madrid__c  where Name =:email.subject] == 0) {
  madrid = new Madrid__c  ();
    madrid.Name = 'New Story by ' + '{!madrid.Real_Name__c}';
  madrid.MEmail__c = email.fromAddress;
  madrid.MContent__c = email.subject;      
  madrid.MDescription__c = email.plainTextBody;      
  insert madrid;
} else {
  madrid = [select Id from Madrid__c  where Name =:email.subject];
}
 
      result.success = true;
      result.message = (email.subject + ' Story Created');
    } catch (Exception e) {
      result.success = false;
      result.message = 'Request Delivery Failed.';
    }
    return result;
  }
}