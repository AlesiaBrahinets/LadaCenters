trigger NewLeadTrigger on Case (after insert) {
    HandlerForCreateLead.createLead(Trigger.new);

}