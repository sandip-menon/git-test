public with sharing class PaginationController1 {
Public List<case> conList {get;set;}
Public List<String> ConFieldList{get;set;}

    public PaginationController1 (){
      conList = New List<Case>();
      ConFieldList = New List<string>();
      conList = [select CaseNumber from case limit 20];
      ConFieldList.add('CaseNumber');
    }
}