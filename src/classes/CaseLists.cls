global class CaseLists {

    public List<Case> results {get;set;}
    public String filterId {get;set;}
    private Id accountId;

    

    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Open', 'Open'));
        options.add(new SelectOption('Closed', 'Closed'));
        options.add(new SelectOption('All', 'All'));
        return options;
    }
}