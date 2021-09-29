public class HandlerForCreateLead {
    public static void createLead(List<Case> listCaseFromTriggerNew){
        List<Case> listCase=[SELECT Id, Subject, SuppliedEmail, SuppliedName
                             FROM Case 
                             WHERE Subject='Test Drive' AND id IN :listCaseFromTriggerNew];
    
        List<String> emailCase=new List<String>();
        for(Case ac:listCase){
            emailCase.add(ac.SuppliedEmail);
        }
    
        List<Lead> listFromLead=[SELECT id, Email FROM Lead WHERE Email IN :emailCase];        
        List<Lead> listNewLead=new List<Lead>();
    
        if(listFromLead.size()==0){
            for(Case cs:listCase){
                listNewLead.add(new Lead(LastName=cs.SuppliedName,
                                         Company='Individual', 
                                         Status='Open - Not Contacted',
                                         Email=cs.SuppliedEmail));     
            }
        }else{
             if(listFromLead.size()!=emailCase.size()){
                 for(Case cs:listCase){
                     if(!checkEmailCase(cs.SuppliedEmail,listFromLead)){
                         listNewLead.add(new Lead(LastName=cs.SuppliedName,
                                         Company='Individual', 
                                         Status='Open - Not Contacted',
                                         Email=cs.SuppliedEmail));    
                      }
                  }
               }
         }
         if(listNewLead.size()>0){
            insert listNewLead;
         }
    }
    
    private static Boolean checkEmailCase(String emailCase, List<Lead> listFromLead){
        Boolean qa=false;
        for (Lead dl:listFromLead){
            if(emailCase==dl.Email){
               return qa=true;
            }
        }
        return qa;
    }

}