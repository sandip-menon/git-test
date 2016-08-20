public with sharing class CaseEditExtension {
    public String Comment
    {
        get;
        set;
    }
    public String Description
    {
        get;
        set;
    }  
    public String Subject
    {
        get;
        set;
    }
    public Boolean UseAssignmentRules
    {
        get;set;
    }
    
    public Case cs;
    ApexPages.StandardController controller;
    
    public CaseEditExtension(ApexPages.StandardController con)
    {
        controller = con;
        this.cs = (Case) con.getRecord();
    }
    
    public PageReference Save()
    {
        CaseComment com = new CaseComment();
        if(Comment.Length() > 0)
        {
            com.commentBody = Comment;
            com.ParentId = cs.Id;
            if(UseAssignmentRules == true)
            {
                AssignmentRule  AR = new AssignmentRule();
                AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
                
                //Creating the DMLOptions for "Assign using active assignment rules" checkbox
                Database.DMLOptions dmlOpts = new Database.DMLOptions();
                dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
                controller.getRecord().setOptions(dmlOpts);                
            }
            insert com;
        }
        String retURL = ApexPages.currentPage().getParameters().get('retURL');
        String CurrentId = ApexPages.currentPage().getParameters().get('id');
        PageReference redirectPG;
        if(retURL != null)
            redirectPG = new PageReference('/' + retURL);
        else if(CurrentId != null)
            redirectPG = new PageReference('/' + CurrentId);
        
        controller.Save();
        
        return redirectPG;
    }
    
    public PageReference SaveAndNew()
    {
        Save();
        return new PageReference('/500/e');
    }
    
    public PageReference SaveAndClose()
    {
        Save();
        String retURL = ApexPages.currentPage().getParameters().get('retURL');
        String CurrentId = ApexPages.currentPage().getParameters().get('id');
        PageReference redirectPG;
        if(retURL != null)
            redirectPG = new PageReference('/' + retURL);
        else if(CurrentId != null)
            redirectPG = new PageReference('/' + CurrentId);
        
        return redirectPG;
    }    
}