public with sharing class MapController {

    @AuraEnabled
    public static List<Car_center__c> getCarCenter() {               
        return [SELECT Name, Address__c, City__c, Country__c, Contact_Phone__c, Email__c
                FROM Car_center__c limit 5]; 
}
    @AuraEnabled
    public static List<Product2> getCars() { 
        List<String> car=new List<String> (); 
        for (AggregateResult agr:[SELECT Name, count(Modification__c) FROM Product2 WHERE Name LIKE 'Lada%' group by Name]){
            String names=(String)agr.get ('Name');
            car.add(names);   
        }

        List< Product2>mod=new List<Product2>();
        String namePr='';
        for (Product2 prod:[select Id, Name from Product2 where Name in : car order by Name]){      
           if(!(namePr==prod.Name)){
              namePr=prod.Name;
              mod.add(prod);
           }   
        }
        return mod; 
}
    @AuraEnabled
    public static List<Modification__c> getModel(String carName) {               
        return [SELECT Id, Name, Color__c, Complectation__c, Engine__c, Specification__c, Product_Name__c FROM Modification__c WHERE Product_Name__c=:carName]; 
}   
    @AuraEnabled
    public static List<ContentVersion> getContents(String carId, String ObjectName) {
        Set<Id> contentIds = new Set<Id>();
        if(ObjectName == 'Modification__c')
        {
            
            for (ContentDocumentLink cont :[SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink where LinkedEntityId in ( SELECT Id FROM Modification__c where Name =:carId) and LinkedEntity.Type=:ObjectName]) {
                contentIds.add(cont.ContentDocumentId);
            }
        }
         else
        {
            //SOQL query to get pictures from Model Object 
 for (ContentDocumentLink cont :[SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink where LinkedEntityId in ( SELECT Id FROM Product2 where Name =:carId ) and LinkedEntity.Type=:ObjectName]) 
            {
                contentIds.add(cont.ContentDocumentId);   
            }
        }
        //Below Query will return the latest image Id uploaded in files 
return [SELECT Id,Title FROM ContentVersion WHERE ContentDocumentId IN :contentIds LIMIT 1];
    }  
    
    
    @AuraEnabled
 public static CenterPagerWrapper fetchCenter(Decimal pageNumber, Integer recordToDisply) {
      Integer pageSize = recordToDisply;
      Integer offset = ((Integer)pageNumber - 1) * pageSize;
    
    // create a instance of wrapper class.
    CenterPagerWrapper obj =  new CenterPagerWrapper();
    // set the pageSize,Page(Number), total records and accounts List(using OFFSET)   
        obj.pageSize = pageSize;
        obj.page = (Integer) pageNumber;
        obj.total = [SELECT count() FROM Car_center__c];
        obj.centers = [SELECT Name, Address__c, City__c, Country__c, Contact_Phone__c, Email__c
                FROM Car_center__c ORDER BY Name LIMIT :recordToDisply OFFSET :offset];
    // return the wrapper class instance .
        return obj;
     }
    
 // create a wrapper class with @AuraEnabled Properties    
 public class CenterPagerWrapper {
    @AuraEnabled public Integer pageSize {get;set;}
    @AuraEnabled public Integer page {get;set;}
    @AuraEnabled public Integer total {get;set;}
    @AuraEnabled public List<Car_center__c> centers {get;set;}
   }
    public List<Pricebook2> getPriceList(){
        List<Pricebook2>priceList = [select id,Name from Pricebook2 limit 10];
        return priceList;
    }
    @AuraEnabled
    public static List<Product2> getCarsForSale() {        
        return [SELECT id, Name,Complectation__c FROM Product2 WHERE Name LIKE 'Lada%'];
    }
    @AuraEnabled 
    public static Case convertLeadAndSaveCase(Case newCase,Lead newLead){ 
        Database.LeadConvert lc = new Database.LeadConvert();
           lc.setLeadId(newLead.id); 
           lc.setOpportunityName(newLead.Title+newLead.Name);
           newCase.Contact.Id=lc.getContactId();
           LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
           lc.setConvertedStatus(convertStatus.MasterLabel);
           Database.LeadConvertResult lcr = Database.convertLead(lc);
           System.assert(lcr.isSuccess());            
        upsert newCase;
        return newCase;
    }
    
    @AuraEnabled    
    public static Lead saveLead(Lead newLead){         
        /*String em=newLead.Email;
       List<Lead> leads=[select id from Lead where Email=:em ];
       if(leads.isEmpty() && newLead.Name!='' && newLead.Email!='' && newLead.Phone!='' ){
           upsert newLead; 
       }else{
           newLead.id=leads[0].Id;
           upsert newLead;
       }*/
        upsert newLead;
        return newLead;
        }
    
}