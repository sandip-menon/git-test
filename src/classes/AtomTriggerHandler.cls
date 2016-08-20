public class AtomTriggerHandler {
    public static void Before(){
		Atom__c cc = [select Id from Atom__c where Id IN :Trigger.newMap.keySet()];
		List <Content_Version__c> cv = new List<Content_Version__c>(); 
		{
			if (cc.Status__c == 'Published') {
				cv.add(new Content_Version__c
						 (Copy_Content__c = cc.Draft__c,
						 Atom__c = cc.id)
			  );
				cc.Atom__c = cc.Draft__c;
			}
		}
		insert cv;
	} 
	/*public static void After(Atom__c c){
		if (c.Status__c == 'Published') {
				c.Atom__c = c.Draft__c;
			}
		}*/
		
}