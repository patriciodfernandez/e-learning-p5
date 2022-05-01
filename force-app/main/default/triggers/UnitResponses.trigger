trigger UnitResponses on UnitResponse__c (before update) {
    UnitResponseTrigger.onBeforeUpdate(Trigger.new, Trigger.oldMap);

}
   