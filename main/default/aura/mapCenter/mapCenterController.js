({
	init: function (cmp, event, helper) {
        cmp.set('v.mapMarkers', [
            {
                location: {
                    Street: '1 Serova St',
                    City: 'Minsk',
                    PostalCode: '220024',
                    Country: 'BY'
                },

                
                icon: 'utility:salesforce1',
                title: 'Lada in Minsk'
            },
            {
                location: {
                    Street: '11 Kamenogorskaya St',
                    City: 'Minsk',
                    PostalCode: '220024',
                    Country: 'BY'
                },

                
                icon: 'utility:salesforce1',
                title: 'Lada in Minsk'
            },

            
        ]);

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