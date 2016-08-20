trigger updateAccountName on Case(before insert,before update)
{

List<Id> accIds = new List<Id>();
List<Account> newaccList = new List<Account>();
//populating AccountIds in the List
for(Case c: trigger.new)
{
//if(c.type=='Trigger_Account')
if(c.recordtypeid=='01261000000kRFv')
{
       accIds.add(c.AccountId);
}

}
List<Account> accList = new List<Account>();
accList = [select id,name from Account where id in:accIds];

for(Account a : accList)

{
a.name='KVS Trigger Account';
newaccList.add(a);
}

if(newaccList.size()>0)
{
   update newaccList;
}


}