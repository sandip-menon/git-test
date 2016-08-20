global with sharing class Temp_Controller {
    
    global String username {get; set;}
    global String password {get; set;}
//  global CustomLoginController () {}    
    global PageReference login() {
        return Site.login(username, password, null); 
    } 
    public String loggedInUser{get; set;}
    
public Navigation_Group__c[] navigation {get; set;}
public Site__c Main {get; set;}
public NavigationGroup[] NavigationGroups {get; set;}

    public PageReference Registerredirect() {

  PageReference rr = new PageReference('/SelfRegister/');
  rr.setRedirect(true);
  return rr;
}


public class NavigationGroup{
    public Id id {get; set;}
    public string label {get; set;}
    public string url {get; set;}
    public boolean isMegaMenu {get; set;}
    public Navigation_Link__c[] links {get; set;}
}

public Temp_Controller(){
/**************   
    map<string, string> chatterMap = new map<string, string>();
    String[] groups = new String[]{};
    Site__c[] site = [select 
                        id, 
                        title__c, 
                        Site_CSS__c, 
                        site_logo__c,
                        (select
                            id, name, isMegaMenu__c, Chatter_Group__c 
                        from Navigation_Groups__r
                        order by sort_order__c asc nulls first
                        ) 
                    from site__c where 
                        domain__c = :URL.getSalesforceBaseUrl().getHost() 
                        or UseAsDefault__c = true 
                    order by UseAsDefault__c asc limit 1];
    if(site.size() == 1){
        this.main = site[0];
        this.navigation = [select id, sort_order__c, name, isMegaMenu__c, chatter_group__c, (select id, Page__c, Name, redirect__c from navigation_links__r order by sort_order__c asc nulls first) from Navigation_Group__c where site__c = :site[0].id order by sort_order__c asc nulls first];
        Id[] GroupIds = new Id[]{};
        map<id, NavigationGroup> GroupMap = new map<id, NavigationGroup>();
        for(navigation_group__c grp : this.main.navigation_groups__r){
            groups.add(grp.Chatter_Group__c);
        }
        for(CollaborationGroup chatter : [select name, id from collaborationgroup where name = :groups]){
            chatterMap.put(chatter.name, chatter.id);
        }
        for(Navigation_Group__c grp : this.main.navigation_groups__r){
            GroupIds.add(grp.id);
            NavigationGroup ng = new NavigationGroup();
                ng.id = grp.id;
                ng.label = grp.name;
                ng.url = '#';
                ng.isMegaMenu = grp.isMegaMenu__c;
                ng.links = new Navigation_Link__c[]{};
                if(grp.chatter_group__c != null && chatterMap.get(grp.chatter_group__c) != null){
                    ng.url = '/apex/group?id='+chatterMap.get(grp.chatter_group__c);
                }
            GroupMap.put(grp.id, ng);
        }
        Navigation_Link__c[] links = [select id, name, Navigation_Group__c, recordtype.name, page__c, redirect__c, (select id, page__c, name, redirect__c from navigation_links__r order by sort_order__c asc nulls first) from navigation_link__c where navigation_group__c = : GroupIds order by sort_order__c asc nulls first];
        for(Navigation_Link__c link : links){
                GroupMap.get(link.Navigation_Group__c).links.add(link);
        }
        this.NavigationGroups = new NavigationGroup[]{};
        for(id record :GroupMap.keySet()){
            this.NavigationGroups.add(GroupMap.get(record));
        }
    }
    *************/

    
    if(UserInfo.getUserType() != 'Guest'){
            loggedInUser = '1';
        } else {
            loggedInUser = '0';
        }
}
}