public with sharing class SamplePagingExample{
  
    //Properties
    public integer PageSize {get;set;}
    public integer PageNumber {get;set;}
    public integer RecordCount {get;set;}
      
    //Constructor
    public SamplePagingExample() {
        PageSize = 10;
        PageNumber = 1;  
        RecordCount = [Select Count() From Account];
    }
      
    public integer PageIndex {
        get { return (PageNumber - 1); }
    }   
      
    public integer PageCount {
        get { return getPageCount(); }
    }
      
    public integer Offset {
        get { return (PageSize * PageIndex); }
    }
      
    public Account[] getAccounts() {
        try {
            Account[] objAccList = [Select Id, Name, Industry, Website, AccountNumber
                                    From Account order by Name
                                    Limit :PageSize
                                    offset :Offset];
                                      
            return objAccList;
        }
        catch (QueryException e) {
            ApexPages.addMessages(e);  
            return null;
        }
    }
      
    public integer LNumber {
        get { return RecordCount == 0 ? 0 : (Offset + 1); }
    }
  
    public integer UNumber {
        get {
            integer iUNum = ((LNumber + PageSize) - 1);
            return (iUnum > RecordCount) ? RecordCount : iUNum;
        }
    }
      
    public boolean AllowMoveNext {
        get{ return ((PageIndex + 1) < PageCount); } } public boolean AllowMovePrev { get{ return (PageIndex > 0); }
    }
      
    public void Prev() {
        PageNumber--;
  
        if (PageNumber <= 0) { PageNumber = 1; } } public void Next() { PageNumber++; if (PageNumber > PageCount) {
            PageNumber = PageCount;
        }
    }
      
    public void Last() {
        PageNumber = PageCount;
    }
  
    public void First() {
        PageNumber = 1;
    }
      
    private integer getPageCount() {
        integer iPageCount = 1;
  
        if (RecordCount != 0 && PageSize != 0) {
            iPageCount = (RecordCount/PageSize) + ((Math.mod(RecordCount, PageSize)) > 0 ? 1 : 0);
        }
        return iPageCount;
    }
}