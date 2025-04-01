public class OpportunityTriggerHandler {
    public static void handleAfterUpdate(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppsMap) {
        List<Opportunity> closedWonOpps = new List<Opportunity>();
        
        for(Opportunity newOpp : newOpps) {
            Opportunity oldOpp = oldOppsMap.get(newOpp.Id);
            if(newOpp.StageName == 'Closed Won' && oldOpp.StageName != 'Closed Won') {
                closedWonOpps.add(newOpp);
            }
        }
        
        if(!closedWonOpps.isEmpty()) {
            CopadoUserStoryService.createUserStoriesForOpportunities(closedWonOpps);
        }
    }
}