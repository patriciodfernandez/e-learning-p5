public class UnitService {
  public static Boolean registerUnitResponse(Id unitId, String jsonAnswer) {
    Savepoint sp = Database.setSavepoint();
    Boolean verify = false;
    try {
      Unit__c unit = [
        SELECT
          Module__c,
          (
            SELECT Id, Numbers_Of_Tries__c
            FROM Units_Response__r
            WHERE Module_response__r.user__c = :UserInfo.getUserId()
            ORDER BY Numbers_Of_Tries__c DESC
            LIMIT 1
          ),
          (SELECT Id, Name FROM Questions__r)
        FROM Unit__c
        WHERE Id = :unitId
      ];

      Module_Response__c moduleResp = [
        SELECT Id
        FROM Module_Response__c
        WHERE
          Module__c = :unit.Module__c
          AND User__c = :UserInfo.getUserId()
          AND Status__c = 'In Progress '
      ];

      if (moduleResp == null) {
        moduleResp = new Module_Response__c(
          User__c = userInfo.getUserId(),
          Module__c = unit.Module__c,
          Status__c = 'In Progress'
        );
        insert moduleResp;
      }

      Unit_Response__c unitResp = new Unit_Response__c(
        Unit__c = unitId,
        Module_Response__c = moduleResp.Id,
        Status__c = 'Draft'
      );
      unitResp.Numbers_Of_Tries__c = !unit.Units_Response__r.isEmpty()
        ? unit.Units_Response__r[0].Numbers_Of_Tries__c + 1
        : 1;
      insert UnitResp;
      Map<Id, Id> answerMap = (Map<Id, Id>) JSON.deserialize(
        jsonAnswer,
        Map<Id, Id>.class
      );
      List<Question_Response__c> questionRespList = new List<Question_Response__c>();
      // for (Id questionId : answerMap.keySet()){
      for (Question__c question : unit.Questions__r) {
        if (answerMap.containsKey(question.Id)) {
          Question_Response__c questionResp = new Question_Response__c(
            Question__c = question.iD,
            Unit_Response__c = unitResp.Id,
            Option__c = answerMap.get(question.Id)
          );
          questionRespList.add(questionResp);
        } else {
          // throw new CustomException(
          //   'La pregunta ' + ' no fue respondida y es requerida'
          // );
          System.debug('La pregunta no fue respondida y es requerida');
        }
      }
      insert questionRespList;
      unitResp.Status__c = 'Answered';
      update unitResp;

      verify = true;
    } catch (Exception e) {
      Database.rollback(sp);
      throw e;
    }
    return verify;
  }
}
