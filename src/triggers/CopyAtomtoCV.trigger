trigger CopyAtomtoCV on Atom__c (after insert, before update) {
    List <Content_Version__c> cv = new List<Content_Version__c>(); 
    for (Atom__c cc: Trigger.New) {
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