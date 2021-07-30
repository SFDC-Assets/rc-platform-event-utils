public class rcTriggerCountHandler {

    // the current context of the trigger, overridable in tests
    @TestVisible
    private TriggerContext context;
    
    @TestVisible
    private Boolean isTriggerExecuting;
    
    private String objectName;
    
    // constructor
    public rcTriggerCountHandler(String objectName) {
        this.objectName = objectName;
        this.setTriggerContext();
        System.debug('rcTriggerCountHandler > objectName: ' + objectName + ', context: ' + context);
    }

    /***************************************
    * public instance methods
    ***************************************/

    // main method that will be called during execution
    public void run() {

        Integer size = 0;       
        
        switch on this.context {
            when AFTER_INSERT {
                size = Trigger.New.size(); 
            }
            when AFTER_UPDATE {
                size = Trigger.New.size(); 
            }
            when AFTER_DELETE {
                size = Trigger.Old.size(); 
            }
            when AFTER_UNDELETE {
                size = Trigger.New.size(); 
            }
        }
        
        rcCountCache.putUpdate(objectName, size);

    } // end run


  	/***************************************
   	* private instance methods
   	***************************************/

    @TestVisible
    private void setTriggerContext() {
        this.setTriggerContext(null, false);
    }

    @TestVisible
    private void setTriggerContext(String ctx, Boolean testMode) {
        if(!Trigger.isExecuting && !testMode) {
            this.isTriggerExecuting = false;
            return;
        } else {
            this.isTriggerExecuting = true;
        }
    
        if((Trigger.isExecuting && Trigger.isAfter && Trigger.isInsert) ||
            (ctx != null && ctx == 'after insert')) {
          this.context = TriggerContext.AFTER_INSERT;
        } else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isUpdate) ||
            (ctx != null && ctx == 'after update')) {
          this.context = TriggerContext.AFTER_UPDATE;
        } else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isDelete) ||
            (ctx != null && ctx == 'after delete')) {
          this.context = TriggerContext.AFTER_DELETE;
        } else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isUndelete) ||
            (ctx != null && ctx == 'after undelete')) {
          this.context = TriggerContext.AFTER_UNDELETE;
        }
	}

    // possible trigger contexts
    @TestVisible
    private enum TriggerContext {
        	BEFORE_INSERT, BEFORE_UPDATE, BEFORE_DELETE,
            AFTER_INSERT, AFTER_UPDATE, AFTER_DELETE, AFTER_UNDELETE
            }

    // exception class
    public class rcTriggerCountHandlerException extends Exception {}

}