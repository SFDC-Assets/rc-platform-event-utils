trigger rcOpportunityTrigger on Opportunity (after insert, after update, after delete, after undelete) {
	new rcOpportunityTriggerHandler().run();
}