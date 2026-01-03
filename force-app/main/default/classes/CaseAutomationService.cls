public with sharing class CaseAutomationService {

    public static void processCases(Set<Id> caseIds) {
        service().processCases(caseIds);
    }

    private static ICaseAutomationService service() {
        return (ICaseAutomationService) SFDC_Application.Service.newInstance(ICaseAutomationService.class);
    }
}