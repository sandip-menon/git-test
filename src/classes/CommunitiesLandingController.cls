public with sharing class CommunitiesLandingController {

    // Code we will invoke on page load.
    public PageReference forwardToStartPage() {
        String communityUrl = 'http://export.gov/';
        String customHomePage = '_ui/core/chatter/ui/ChatterPage';
    if (UserInfo.getUserType().equals('Guest')) {
        return new PageReference(communityUrl + 'CustomLogin');
    } else {
        return new PageReference(communityUrl + customHomePage);
        }
    }

    public CommunitiesLandingController() {}
}