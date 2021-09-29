({
               
    clickCreate: function(component, event) {
        let newCs = component.get("v.newCase");
        let action = component.get("c.saveCase");
        action.setParams({
            "newCase": newCs
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