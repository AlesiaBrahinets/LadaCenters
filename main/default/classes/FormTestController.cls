public class FormTestController {
    @AuraEnabled
    public static List<Car_center__c> getListCenters() {
        List<Car_center__c> listCenters = [SELECT  Name, What_center__c, City__c, Address__c, Contact_Phone__c, Email__c  FROM  Car_center__c LIMIT 4];
        return listCenters;
    }

}