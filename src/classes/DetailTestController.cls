public class DetailTestController {

   public Id chosenId {get; set;}
   
   public List<Account> getAccounts()
   {
       return [select id, Name from Account limit 10];
   }
}