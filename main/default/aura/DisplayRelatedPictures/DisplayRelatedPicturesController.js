({
    doInit : function(component, event, helper) {
        var action = component.get("c.getCars");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                var finalCarList = response.getReturnValue();  
                component.set("v.carList",finalCarList);  
            }
        });
        $A.enqueueAction(action);  
    },

    onPictureClick: function(component, event, helper) {
        var createRecordEvent = $A.get("e.force:onPictureClick");
        var selectedRecord = event.currentTarget;
        var propId =  selectedRecord.getAttribute("title");
        var action = component.get("c.getModel");
        action.setParams({
            carName : propId
        })
         action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var finalModelList = response.getReturnValue();
                component.set("v.modelList", finalModelList); 
                alert(JSON.stringify(finalModelList));
                 component.set("v.isFirst", false); 
                 component.set("v.isSecond", true);
            }
        });
        $A.enqueueAction(action);
    },
    backClick : function(component, event, helper) {
        component.set("v.isFirst", true); 
        component.set("v.isSecond", false);
    },
    
 openModal: function(component, event, helper) {
        helper.modalOpen(component, event, helper);
    },
    closeModal: function(component, event, helper) {
        helper.modalClose(component, event, helper);
    },
    
  downloadDocument : function(component, event, helper){
       let sendDataProc = component.get("v.sendData");
       let dataToSend = {
                "label" : "This is test"
                }; 
       sendDataProc(dataToSend, function(){
              
  });
 }
})