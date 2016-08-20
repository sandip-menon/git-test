global with sharing class lc {
    global String username{get;set;}
    global String password{get;set;}
    global lc () {}
    global PageReference forwardToCustomAuthPage() {
        return new PageReference( '/CustomLogin');
    }
    global PageReference login() {
        return Site.login(username, password, null);
    }

}