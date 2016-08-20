global with sharing class CLC {
    global String username {get; set;}
    global String password {get; set;}
    global CLC () {}
    global PageReference login() {
        return Site.login(username, password, null); 
    } 
}