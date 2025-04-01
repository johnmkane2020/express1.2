public class CopadoUserStoryService {
    private static final String PROJECT_ID = 'a15Hr000005AdPRIA0'; // CloudflareExpress Project Id
    private static final String TEAM_ID = 'a1hHr000006uu0wIAA'; // L2O Team Id
    
    public static void createUserStoriesForOpportunities(List<Opportunity> opportunities) {
        List<copado__User_Story__c> storiesToCreate = new List<copado__User_Story__c>();
        
        // Get the User Story record type Id
        Id userStoryRecordTypeId = Schema.SObjectType.copado__User_Story__c
            .getRecordTypeInfosByDeveloperName()
            .get('User_Story')
            .getRecordTypeId();
        
        for(Opportunity opp : opportunities) {
            // Create 5 user stories for each Closed Won opportunity
            for(Integer i = 1; i <= 5; i++) {
                copado__User_Story__c story = new copado__User_Story__c(
                    RecordTypeId = userStoryRecordTypeId,
                    copado__Project__c = PROJECT_ID,
                    copado__Team__c = TEAM_ID,
                    copado__User_Story_Title__c = 'Item ' + i,
                    copado__Status__c = 'Draft'
                );
                storiesToCreate.add(story);
            }
        }
        
        if(!storiesToCreate.isEmpty()) {
            try {
                insert storiesToCreate;
            } catch(Exception e) {
                System.debug('Error creating User Stories: ' + e.getMessage());
                throw new CopadoUserStoryException('Failed to create User Stories: ' + e.getMessage());
            }
        }
    }
    
    public class CopadoUserStoryException extends Exception {}
}