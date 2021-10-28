({
	createCase: function(component, newCase) {
        let action = component.get("c.saveCase");
        action.setParams({
            "newCase": newCase
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.caseId", response.getReturnValue().Id);
                component.set("v.newCase", response.getReturnValue());               
               } 
            });
        $A.enqueueAction(action);
        
    }
        
})