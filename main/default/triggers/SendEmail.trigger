trigger SendEmail on Case (after insert) {
    SendEmailHandler.sendEmail(Trigger.new);

}