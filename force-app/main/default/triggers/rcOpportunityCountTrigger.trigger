trigger rcOpportunityCountTrigger on Opportunity (after insert, after update, after delete, after undelete) {
    new rcTriggerCountHandler(Opportunity.class.getName());
}