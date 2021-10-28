({
	giveForm: function(component, event, helper) {       
        component.set("v.newLead",{ 
                        'sobjectType': 'Lead',
                        'Name': '',
                        'Phone': '',
                        'Email': '',
                        'Company':'Individual', 
                        'Title': 'Order car'
                        });
        component.set("v.LeadId",'');
        component.set("v.answer",'' );
        component.set("v.isFirst", false); 
        component.set("v.isSecond",true );
        
        
    },
    clickCreate: function(component, event,helper) {
        let validExpense = component.find('leadform').reduce(function (validSoFar, inputCmp) { 
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);  
        alert(validExpense);
        if(validExpense){
        let newLead = component.get("v.newLead");
        alert(JSON.stringify(newLead));                  
        helper.createLead(component, newLead);            
        }
    },
    backClickOne : function(component, event, helper) {        
        component.set("v.isFirst", true); 
        component.set("v.isSecond", false); 
    },
    backClickTwo : function(component, event, helper) {        
        component.set("v.isThird", true); 
        component.set("v.isSecond", false); 
    },
    confirm:function(component, event, helper) {
        let newCase={
                        'sobjectType': 'Case',
                        'SuppliedEmail': '',
                        'Subject': 'Order car',
                        'Status':'Closed'
        };
         let newLead = component.get("v.newLead");
         newCase.SuppliedEmail=newLead.Email;
        helper.convertAndSave(component,newCase,newLead);
    }
})