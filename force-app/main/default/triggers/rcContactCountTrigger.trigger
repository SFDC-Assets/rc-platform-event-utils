/**
 * Created by ryan.cox on 7/28/21.
 */

trigger rcContactCountTrigger on Contact (after insert, after update, after delete, after undelete) {
    new rcTriggerCountHandler(Contact.class.getName()).run();
}