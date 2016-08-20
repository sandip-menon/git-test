public with sharing class PaginationController {
Public List<case> conList {get;set;}
Public List<String> ConFieldList{get;set;}

    public PaginationController (){
      conList = New List<Case>();
      ConFieldList = New List<string>();
      conList = [select CaseNumber, Status, Priority from Case limit 20];
      ConFieldList.add('CaseNumber');
    }
}