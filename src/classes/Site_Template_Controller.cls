public class Site_Template_Controller {

public Navigation_Group__c[] navigation {get; set;}
public Site__c Main {get; set;}
public NavigationGroup[] NavigationGroups {get; set;}

public class NavigationGroup{
    public Id id {get; set;}
    public string label {get; set;}
    public string url {get; set;}
    public boolean isMegaMenu {get; set;}
    public Navigation_Link__c[] links {get; set;}
}

public Site_Template_Controller(){
    Site__c[] site = [select 
                        id, 
                        title__c, 
                        Site_CSS__c, 
                        site_logo__c,
                        (select
                            id, name, isMegaMenu__c 
                        from Navigation_Groups__r
                        order by sort_order__c asc nulls first
                        ) 
                    from site__c where 
                        domain__c = :ApexPages.CurrentPage().getHeaders().get('HOST') 
                        or UseAsDefault__c = true 
                    order by UseAsDefault__c asc limit 1];
    if(site.size() == 1){
        this.main = site[0];
        this.navigation = [select id, sort_order__c, name, isMegaMenu__c, (select id, Page__c, Name from navigation_links__r order by sort_order__c asc nulls first) from Navigation_Group__c where site__c = :site[0].id order by sort_order__c asc nulls first];
        Id[] GroupIds = new Id[]{};
        map<id, NavigationGroup> GroupMap = new map<id, NavigationGroup>();
        for(Navigation_Group__c grp : this.main.navigation_groups__r){
            GroupIds.add(grp.id);
            NavigationGroup ng = new NavigationGroup();
                ng.id = grp.id;
                ng.label = grp.name;
                ng.url = '#';
                ng.isMegaMenu = grp.isMegaMenu__c;
                ng.links = new Navigation_Link__c[]{};
            GroupMap.put(grp.id, ng);
        }
        Navigation_Link__c[] links = [select id, name, Navigation_Group__c, page__c, (select id, page__c, name from navigation_links__r order by sort_order__c asc nulls first) from navigation_link__c where navigation_group__c = : GroupIds order by sort_order__c asc nulls first];
        for(Navigation_Link__c link : links){
                GroupMap.get(link.Navigation_Group__c).links.add(link);
        }
        this.NavigationGroups = new NavigationGroup[]{};
        for(id record :GroupMap.keySet()){
            this.NavigationGroups.add(GroupMap.get(record));
        }
    }
}
}