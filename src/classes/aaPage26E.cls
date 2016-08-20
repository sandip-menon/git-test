public class aaPage26E {
    case t;
    ApexPages.StandardController controller;
    public aaPage26E(ApexPages.StandardController controller) {
        this.controller = controller;
        t = (case) Controller.getRecord();
    }
    public list<SelectOption> getRecordTypes() {
        list<SelectOption> options = new list<SelectOption>();
        for (list<RecordType> rts : [SELECT ID, name FROM RecordType WHERE SObjectType = 'case' ORDER BY name]) {
            for (RecordType rt : rts) {
                options.add(new SelectOption(rt.ID, rt.Name));
            } 
        }
        return options;
    }
}