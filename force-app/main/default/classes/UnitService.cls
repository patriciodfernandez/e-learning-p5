public class UnitService{
    public static Boolean registerUnitResponse(Id unitId, String jsonAnswer){

        Unit__c unit = [SELECT Module__c
                        FROM Unit__c
                        WHERE Id = :unitId];


        Module_Response__c moduleResp = new Module_Response__c(User__c = userInfo.getUserId(), Module__c = unit.Id);

        Unit_Response__c unitResp = new Unit_Response__c(Unit__c = unitId);

        insert UnitResp;
    }

}