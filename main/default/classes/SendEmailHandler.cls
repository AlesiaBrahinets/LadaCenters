public class SendEmailHandler {
    public static void sendEmail(List<Case> listCaseFromTriggerNew){
        List<Case> listCase=[SELECT Id, Subject, ContactId,SuppliedEmail
                             FROM Case 
                             WHERE Subject='Order car' AND Status='Closed' AND id IN :listCaseFromTriggerNew];
        List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();        

for(Case caseOld:listCase){
  Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage ();
  String [] toAddresses = new String [] {caseOld.SuppliedEmail}; 
  mail.setToAddresses (toAddresses); 
  mail.setReplyTo (caseOld.SuppliedEmail); 
  mail.setSenderDisplayName ('Salesforce Support'); 
  mail.setSubject ('Your order is created!'); 
  mail.setBccSender (false); 
  mail.setUseSignature (true);
  EmailTemplate et = [Select Id from EmailTemplate where Name = 'ForContact'];
  mail.setWhatId(caseOld.ContactId);
  mail.setTemplateId(et.Id);  
  allmsg.add(mail);  
}
Messaging.sendEmail(allmsg,false);       
}
}