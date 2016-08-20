public with sharing class PicklistPicker_Class {
    public List<SelectOption> AppraisalTypeList
    {
        get
        {
            List<SelectOption> options = new List<SelectOption>();
            Schema.DescribeFieldResult fieldResult = Appraisal__c.Appraisal_Summary__c.getDescribe();
               List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
       
           for( Schema.PicklistEntry f : ple)
           {
              options.add(new SelectOption(f.getLabel(), f.getValue()));
           }      
           return options;
        }
        set;
    }
    public String SelectedAppraisalType
    {get;set;}
    public String SelectedAppraisalSummaryType
    {get;set;}
    public String SelectedName
    {get;set;}
    public Appraisal__c dummyAppraisal
    {
        get
        {
            if(dummyAppraisal==null)
                dummyAppraisal = new Appraisal__c();
            return dummyAppraisal;
        }
        set;
    }
    public void Save()
    {
        opMessage = 'You added name = ' + SelectedName;
        opMessage = opMessage + '.... And you selected picklist value = ' + SelectedAppraisalSummaryType;
    }
    public String opMessage
    {get;set;}
}