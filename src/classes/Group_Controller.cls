public with sharing class Group_Controller {

public boolean hasId {get; set;}
public CollaborationGroup ChatterGroup {get; set;}
public CollaborationGroup[] groups {get; set;}

public Group_Controller(){
    string id = ApexPages.CurrentPage().getParameters().get('id');
    if(id == null){
        this.hasId = false;
        this.groups = [select id, name, CanHaveGuests, Description from collaborationgroup where NetworkId = :Network.getNetworkId()];
    }else{
        this.hasId = true;
        this.ChatterGroup =  [select id, name, CanHaveGuests, Description, (select title, body from feeds) from collaborationgroup where id = :id limit 1];        
    }
}

}