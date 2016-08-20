global class CompanyCasesQue {
public string FilterId{get;set;}
public list<case> results;
    //constructors and variable declaration

    public PageReference renderdiffview() {
    Map<Id,string> Id_status_map = new map<Id,string>{'00BW0000000PeSVMA0' => 'New','00BW0000000PeSGMA0' => 'Closed'};
    results = [select id,casenumber from case where status =: Id_status_map.get(filterId)];
     return null;
    }

    public List<Case> getresults() {       
     return results;
    }
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('00BW0000000PeSVMA0','View All Open Cases'));
        options.add(new SelectOption('00BW0000000PbzWMAS','View All Cases'));
        options.add(new SelectOption('00B610000037MUE','Action Req Cases'));
        return options;
    }
}