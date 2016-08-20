public with sharing class CaseSearchController {
   public list <case> acc {get;set;}  
   public string searchstring {get;set;}  
   public CaseSearchController(ApexPages.StandardController controller) {  
   }  
   public void search(){  
     string searchquery='select CaseNumber,id,Priority,Status,Cc_Email__c,Contact_Address__c,Does_this_complaint__c,EngineeringReqNumber__c,PotentialLiability__c,Product__c,SLAViolation__c,Tell_us_how_you_heard_about_us__c,Tell_us_the_problem_in_your_own_words__c from case where CaseNumber like \'%'+searchstring+'%\' Limit 20';  
     acc= Database.query(searchquery);  
   }  
   public void clear(){  
   acc.clear();  
   }  
 }