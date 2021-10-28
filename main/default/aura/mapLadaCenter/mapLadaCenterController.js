({
	
	init: function (cmp, event, helper) {
        let action = cmp.get("c.getCarCenter");
        let mapMarkers=[];
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
            let listCenter=response.getReturnValue();                
                for(let i=0;i<listCenter.length;i++){
                    let  {Address__c,City__c,Country__c,Name}=listCenter[i];  
                    let center={
                               location: {
                                  Street: Address__c,
                                  City: City__c,                  
                                  Country: Country__c
                                },                              
                                title: Name
                                };                   
                     mapMarkers[i]=center;                   
                }
             cmp.set('v.mapMarkers',mapMarkers);
            } else{
                console.log(state);
            } 
        });
        $A.enqueueAction(action);
        cmp.set('v.center', {
            location: {
                City: 'Minsk'
            },
        });
        cmp.set('v.zoomLevel', 8);
        cmp.set('v.markersTitle', 'Salesforce locations in Minsk');
        cmp.set('v.showFooter', true);
    }

})