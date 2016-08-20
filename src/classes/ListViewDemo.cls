public with sharing class ListViewDemo {

  private String baseQuery = 'Select ID, Name FROM Account ORDER BY NAME ASC';
  public String AccFilterId {get; set;}
  private Integer pageSize = 10;
  public ListViewDemo(){}
  public ApexPages.StandardSetController AccSetController {
        get{
            if(AccSetController == null){
                AccSetController = new ApexPages.StandardSetController(Database.getQueryLocator(baseQuery));
                AccSetController.setPageSize(pageSize);

                // We have to set FilterId after Pagesize, else it will not work
                if(AccFilterId != null)
                {
                  AccSetController.setFilterId(AccFilterId);
                }
            }
            return AccSetController;
        }set;
    }
    public List<Account> getAccounts()
    {
      return (List<Account>)AccSetController.getRecords();
    }

    //Get all available list view for Account
    public SelectOption[] getAccountExistingViews(){
        return AccSetController.getListViewOptions();
    }

    /**
    * Reset List View
    */
    public PageReference resetFilter()
    {
      AccSetController = null;
        AccSetController.setPageNumber(1);
        return null;
    }

}