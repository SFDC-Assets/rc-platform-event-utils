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

        Integer size = Trigger.New.size();
        rcCountCache.putUpdate(objectName, size);

        /*
        // dispatch to the correct handler method
        switch on this.context {
            when BEFORE_INSERT {
                //this.beforeInsert();
            }
            when BEFORE_UPDATE {
                //this.beforeUpdate();
            }
            when BEFORE_DELETE {
                //this.beforeDelete();
            }
            when AFTER_INSERT {
                //this.afterInsert();
            }
            when AFTER_UPDATE {
                //this.afterUpdate();
            }
            when AFTER_DELETE {
                //this.afterDelete();
            }
            when AFTER_UNDELETE {
                //this.afterUndelete();
            }
        }
        */

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
    
        if((Trigger.isExecuting && Trigger.isBefore && Trigger.isInsert) ||
            (ctx != null && ctx == 'before insert')) {
          this.context = TriggerContext.BEFORE_INSERT;
        } else if((Trigger.isExecuting && Trigger.isBefore && Trigger.isUpdate) ||
            (ctx != null && ctx == 'before update')){
          this.context = TriggerContext.BEFORE_UPDATE;
        } else if((Trigger.isExecuting && Trigger.isBefore && Trigger.isDelete) ||
            (ctx != null && ctx == 'before delete')) {
          this.context = TriggerContext.BEFORE_DELETE;
        } else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isInsert) ||
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