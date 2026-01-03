public with sharing class CaseAutomationEnqueuer {
    public static void enqueue(Set<Id> caseIds) {
        if (caseIds == null || caseIds.isEmpty()) return;
        System.enqueueJob(new CaseAutomationJob(caseIds));
    }
}