public class rcOpportunityTriggerHandler extends TriggerHandler {

  private Map<Id, Opportunity> newMap;

  public rcOpportunityTriggerHandler() {
    this.newMap = (Map<Id, Opportunity>) Trigger.newMap;
  }
  
  public override void afterUpdate() {
    //
  }
    
}