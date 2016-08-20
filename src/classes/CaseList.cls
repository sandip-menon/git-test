public class CaseList
{
    public id recordtype {get; set;}
    public string casediv {get; set;}
    public Case c {get; set;}
    public Case[] cases {get; set;}
    
    public void SetRecordTypeId() {
        this.recordtype = ApexPages.currentPage().getParameters().get('recordtypeid');
        this.casediv = ApexPages.currentPage().getParameters().get('casediv');
    }

    public PageReference StartNewCase() {
        PageReference pr = new PageReference('/apex/case+');    
        pr.setRedirect(true);
        return pr;
    }
      
    public RecordType[] getRecordTypes(){
        return [select id, developername, name, description from recordtype where sobjecttype = 'Case'];
    }

    public CaseList()
    {
        this.c = new case();
        this.cases = [SELECT CaseNumber, Status, Subject, CreatedDate FROM Case order by CreatedDate];
    }
    
    public void save() {
        
        try{
            this.c.status = 'New';
            this.c.contactid = this.getContactId();
            insert this.c;
        }catch(Exception e){
            Apexpages.AddMessages(e);
        }
    }
    private id getContactId(){
        return [select contactid from User where id = :UserInfo.getUserId() limit 1].contactid;
    }
    
}