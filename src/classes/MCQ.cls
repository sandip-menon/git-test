global class MCQ {

    public List<Case> results {get;set;}
    public String filterId {get;set;}
    // public previousSortField {get;set;}
    private Id accountId;

    public PageReference processRequests()
    {
        
        //write the query for getting the data based on filterId
        if (filterId == 'All') {
            results = [select Id, CaseNumber, AccountId, Subject, Priority, Status, CreatedDate, ContactId from Case where AccountId = :accountId order by CaseNumber desc limit 100];
        } else if (filterId == 'Total Closed') {
            results = [select Id, CaseNumber, AccountId, Subject, Priority, Status, CreatedDate, ContactId from Case where Status = 'Closed' order by CaseNumber desc limit 100]; 
        } else if (filterId == 'Total Open') {
            results = [select Id, CaseNumber, AccountId, Subject, Priority, Status, CreatedDate, ContactId from Case where Status = 'New' order by CaseNumber desc limit 100]; 
        }
        else {
            results = [select Id, CaseNumber, AccountId, Subject, Priority, Status, CreatedDate, ContactId from Case where Status = :filterId and AccountId = :accountId order by CaseNumber desc limit 100]; 
        }
        return null;
    }

    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Open', 'Open'));
        options.add(new SelectOption('Closed', 'Closed'));
        options.add(new SelectOption('All', 'All'));
        options.add(new SelectOption('Total closed', 'Total closed'));
        options.add(new SelectOption('Total Open', 'Total Open'));                
        return options;
    }
}