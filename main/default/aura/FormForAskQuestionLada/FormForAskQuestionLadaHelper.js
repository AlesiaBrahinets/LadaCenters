({
	createCase: function(component, newCase) {
        let action = component.get("c.saveCase");
        action.setParams({
            "newCase": newCase
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.newCase", response.getReturnValue());
                component.set("v.isFirst", true); 
        component.set("v.isSecond",false );
               } 
            });
        $A.enqueueAction(action);
        
    }
})