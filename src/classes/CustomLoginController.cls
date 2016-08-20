//*    global with sharing class CustomLoginController {
//*    global String username {get; set;}
//*    global String password {get; set;}

//*    global PageReference login() {
//*        String startUrl = System.currentPageReference().getParameters().get('startURL');
//*        return Site.login(username, password, startUrl);
//*    }
//*    
//*     global CustomLoginController () {}
//*    
//*       
//*}

global with sharing class CustomLoginController {
    global String username{get;set;}
    global String password{get;set;}
    global CustomLoginController () {}
    global PageReference forwardToCustomAuthPage() {
        return new PageReference( '/CustomLogin');
    }
    global PageReference login() {
        return Site.login(username, password, null);
    }
    
    public string firstName=UserInfo.getFirstName();

public PageReference Registerredirect() {

  PageReference rr = new PageReference('/SelfRegister/');
  rr.setRedirect(true);
  return rr;
}

   
    public boolean visible=FALSE;
    public boolean getVisibile()
    {
        if(firstName!='Sandip')
        {
             visible=TRUE;
        }
        else
        {
             visible=FALSE;  
        }
        return visible;
    }

}