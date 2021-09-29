({
    getCenters : function(component, event) {
        var action = component.get("c.getListCenters");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
              
                component.set("v.centers", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }

})