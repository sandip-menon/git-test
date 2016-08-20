public with sharing class soql_offset_example {


public id recordtype {get; set;}
    public contact con {get; set;}
    public string casediv {get; set;}
    public Case c {get; set;}
    public Case[] openCases {get; set;}
    public Case[] actionReqCases {get; set;}
    public Case[] orgOpenCases {get; set;}
    public Case[] Cases {get; set;}
    public String filterId {get;set;}
    public List<Case> results {get;set;}
    public Attachment attachment {get; set;}
   private integer counter=0;  //keeps track of the offset
   private integer list_size=10; //sets the page size or number of rows
   public integer total_size; //used to show user the total size of the list

   public soql_offset_example() {
   total_size = [select count() from Case]; //set the total size in the constructor
   }

    {
        this.openCases = [SELECT CaseNumber, Status, Subject, CreatedDate, LastModifiedDate FROM Case where contactid = :getcontactid() and status <> 'Closed' order by CreatedDate];
        this.actionReqCases = [select Id, CaseNumber, AccountId, Subject, Priority, Status, CreatedDate, ContactId, LastModifiedDate from Case where contactid = :getcontactid() and Status = 'Action Required'];
        this.orgOpenCases = [select Id, CaseNumber, AccountId, Subject, Priority, Status, CreatedDate, ContactId, LastModifiedDate from Case where AccountId = :getaccountId() and Status <> 'Closed' order by CaseNumber];
        this.Cases = [select Id, CaseNumber, AccountId, Subject, Priority, Status, CreatedDate, ContactId, LastModifiedDate from Case where AccountId = :getaccountId() and Status <> 'Closed' order by CaseNumber];
        this.results = [select Id, CaseNumber, AccountId, Subject, Priority, Status, CreatedDate, ContactId, LastModifiedDate from Case where contactid = :getcontactid() and status <> 'Closed' order by CaseNumber Limit 100];
        this.c = new case();
        total_size = results.size(); //set the total size
    }
    //End Constructor    
    
    //Start caselist filter criteria 
    public PageReference processRequests()
    {
        if (filterId == 'My Organization Open Cases') {
            results = [select Id, CaseNumber, AccountId, Subject, Priority, Status, CreatedDate, ContactId, LastModifiedDate from Case where AccountId = :getaccountId() and Status <> 'Closed' order by CaseNumber limit :list_size 
                                offset :counter];
        } else if (filterId == 'Action Required') {
            results = [select Id, CaseNumber, AccountId, Subject, Priority, Status, CreatedDate, ContactId, LastModifiedDate from Case where contactid = :getcontactid() and Status = 'Action Required' order by CaseNumber limit :list_size 
                                offset :counter]; 
        } else if (filterId == 'My Open Cases') {
            results = [select Id, CaseNumber, AccountId, Subject, Priority, Status, CreatedDate, ContactId, LastModifiedDate from Case where contactid = :getcontactid() and status <> 'Closed' order by CaseNumber limit :list_size 
                                offset :counter]; 
        } 
        else {
            results = [select Id, CaseNumber, AccountId, Subject, Priority, Status, CreatedDate, ContactId, LastModifiedDate from Case]; 
        }
        return null;
    }

   public Case[] getCase() {
      try {
         Case[] numbers = [select CaseNumber 
                                from Case 
                                order by CaseNumber 
                                limit :list_size 
                                offset :counter];

         return numbers;
      } catch (QueryException e) {
         ApexPages.addMessages(e);   
         return null;
      }
   }

public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('My Open Cases', 'My Open Cases'));
        options.add(new SelectOption('Action Required', 'Action Required'));
        options.add(new SelectOption('My Organization Open Cases', 'My Organization Open Cases'));
        return options;
    }
    //End caselist filter criteria
    
    //get the record types related to the case object, filter by Case__c custom setting
    
    public void SetRecordTypeId() {
        this.recordtype = ApexPages.currentPage().getParameters().get('recordtypeid');
        this.casediv = ApexPages.currentPage().getParameters().get('casediv');
        system.debug('@@: '+this.casediv);
    }
    
    public Pagereference save() {
        try{
            this.c.status = 'New';
            this.c.contactid = this.getContactId();
            this.c.recordtypeid = this.recordtype;
            system.debug('@@THIS: '+this.c);
            system.debug('@@: '+c);
            insert this.c;
        }catch(Exception e){
            Apexpages.AddMessages(e);
        }
        PageReference casehome = new PageReference('/apex/cases');
        casehome.setRedirect(true);
        return casehome;
    }
    
    public PageReference NewCase() {
        PageReference pr = new PageReference('/apex/case');    
        pr.setRedirect(true);
        return pr;
    }
    
    public pageReference cancel() {
        PageReference cc= new PageReference('/apex/cases');    
        cc.setRedirect(true);
        return cc;
    }

    private id getContactId(){
        return [select contactid from User where id = :UserInfo.getUserId() limit 1].contactid;
    }
    
    private id getAccountId(){
        return [select accountid from User where id = :UserInfo.getUserId() limit 1].accountid;   
    } 
    
    //Start attachment 
    public Attachment getattachment() {
        attachment = new Attachment();
        return attachment;
    }

    public PageReference upload() {
        attachment.OwnerId = UserInfo.getUserId();
        attachment.ParentId = this.c.id; // the record the file is attached to
        attachment.IsPrivate = true;

        try {
          insert attachment;
        } catch (DMLException e) {
          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
          return null;
        } finally {
          attachment = new Attachment(); 
        }

        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));
        return null;
    }//End attachment

   public PageReference Beginning() { //user clicked beginning
      counter = 0;
      return null;
   }

   public PageReference Previous() { //user clicked previous button
      counter -= list_size;
      return null;
   }

   public PageReference Next() { //user clicked next button
      counter += list_size;
      return null;
   }

   public PageReference End() { //user clicked end
      counter = total_size - math.mod(total_size, list_size);
      return null;
   }

   public Boolean getDisablePrevious() { 
      //this will disable the previous and beginning buttons
      if (counter>0) return false; else return true;
   }

   public Boolean getDisableNext() { //this will disable the next and end buttons
      if (counter + list_size < total_size) return false; else return true;
   }

   public Integer getTotal_size() {
      return total_size;
   }

   public Integer getPageNumber() {
      return counter/list_size + 1;
   }

   public Integer getTotalPages() {
      if (math.mod(total_size, list_size) > 0) {
         return total_size/list_size + 1;
      } else {
         return (total_size/list_size);
      }
   }
}