trigger rcAccountCountTrigger on Account (after insert, after update, after delete, after undelete) {
    new rcTriggerCountHandler(Account.class.getName()).run();
}