public with sharing class CaseAutomationJob implements Queueable {
    private final Set<Id> caseIds;

    public CaseAutomationJob(Set<Id> caseIds) {
        this.caseIds = caseIds == null ? new Set<Id>() : new Set<Id>(caseIds);
    }

    public void execute(QueueableContext context) {
        CaseAutomationService.processCases(caseIds);
    }
}