public with sharing class CaseController {

    
    @AuraEnabled
    public static List<Case> getCases() {
         List<Case> ListCs=[SELECT id, Subject
                FROM Case Limit 10];
        return ListCs;            
      }
    
    @AuraEnabled
    public static Case saveCase(Case newCase) {  
        upsert newCase;
        return newCase;
    }

}