({
    doInit: function(component, event, helper) {       
        component.set("v.newCase",{ 
                        'sobjectType': 'Case',
                        'SuppliedName': '',
                        'SuppliedEmail': '',
                        'Subject': 'Test Drive'}); 
    },
    clickCreate: function(component, event,helper) {
        let validExpense = component.find('caseform').reduce(function (validSoFar, inputCmp) { 
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);        
        if(validExpense){
        let newCase = component.get("v.newCase");
        helper.createCase(component, newCase);            
        }
    }
      
})