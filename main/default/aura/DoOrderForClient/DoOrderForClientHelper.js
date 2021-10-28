({
	createLead: function(component, newLead) {
        let action = component.get("c.saveLead");
        action.setParams({
            "newLead": newLead
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            alert(state);
            if (state === "SUCCESS") {
                component.set("v.LeadId", response.getReturnValue().Id);
                component.set("v.newLead", response.getReturnValue()); 
                component.set("v.isSecond",false );
                component.set("v.isThird",true );   
                alert(JSON.stringify(response.getReturnValue()));
               } 
            });
        $A.enqueueAction(action);        
    },
    
    convertAndSave: function(component, newLead, newCase) {
        let action = component.get("c.convertLeadAndSaveCase");
        action.setParams({
            "newCase": newCase,
            "newLead": newLead
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            alert(state);
            if (state === "SUCCESS") {               
                component.set("v.newCase", response.getReturnValue()); 
                component.set("v.isThird",false );
                component.set("v.isFirst",true );
                component.set("v.answer",'is created');
                alert(JSON.stringify(response.getReturnValue()));
               } 
            });
        $A.enqueueAction(action);        
    } 
})