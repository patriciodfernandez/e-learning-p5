public class UnitResponseTrigger{

    // public static void onBeforeUpdate(List<UnitResponse__c> unitRespList, Map<Id,UnitResponse__c> oldUnitRespMap){
    //     List<UnitResponse__c> answeredUnitRespList = new List<UnitResponse__c>();
    //     for(UnitResponse__c unitResp : unitRespList){
    //         if(unitResp.Status__c == 'Answered' && oldUnitRespMap.get(unitResp.Id).Status__c == 'Draft'){
    //             answeredUnitRespList.add(unitResp);
    //         }
    //     }

    //     validateAnswers(answeredUnitRespList);
    // }

    // private static void validateAnswers(List<UnitResponse__c> unitRespList){
        
    //     Map<Id,UnitResponse__c> unitRespFromDbMap = new Map<Id,UnitResponse__c>([SELECT Id, (SELECT Id, Option__r.IsCorrect__c FROM QuestionResponses__r) WHERE Id in 
    //     : unitRespList]);

    //     //200
    //     for(UnitResponse__c unitResp : unitRespList){

    //         unitResp.IsCorrect__c = true;
    //         //10
    //         for(QuestionResponse__c questionResp : unitRespFromDbMap.get(unitResp.Id).QuestionResponses__r){
    //             //10 * 200 = 2000
    //             if(!questionResp.Option__r.IsCorrect__c){
    //                 unitResp.Status__c = false;
    //                 break;
    //             }
    //         }
    //     }
    // }

}