trigger AccountTrigger on Account (after insert,after update) {
    if((trigger.isAfter && trigger.isInsert) ||(trigger.isAfter && trigger.isUpdate)){
        AccountTriggerHelper.createCase(trigger.new);
    }

}