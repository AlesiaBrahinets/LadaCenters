({
	modalOpen: function(component, event, helper) {
        let product = event.getSource().get('v.value');
        component.set('v.product', product );
        let modal = component.find("carModal");
        let modalBackdrop = component.find("carModalBackdrop");
        $A.util.addClass(modal,"slds-fade-in-open");
        $A.util.addClass(modalBackdrop,"slds-backdrop slds-backdrop_open");
    },
    modalClose: function(component, event, helper) {
        let modal = component.find("carModal");
        let modalBackdrop = component.find("carModalBackdrop");
        $A.util.removeClass(modal,"slds-fade-in-open");
        $A.util.removeClass(modalBackdrop,"slds-backdrop_open");
    }
})