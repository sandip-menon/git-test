global class EmailToSalesForce implements Messaging.InboundEmailHandler {
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, 
                                                         Messaging.Inboundenvelope envelope) {
  
Madrid__c  madrid;
Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();

try {

// Look for customobject  whose name is the subject and create it if necessary
if ([select count() from Madrid__c  where Name =:email.subject] == 0) {
  madrid = new Madrid__c  ();
  madrid.Name = email.subject;
  insert madrid;
} else {
  madrid = [select Id from Madrid__c  where Name =:email.subject];
}
 
      result.success = true;
      result.message = (email.subject + ' matched');
    } catch (Exception e) {
      result.success = false;
      result.message = 'Oops, I failed.';
    }
    return result;
  }
}