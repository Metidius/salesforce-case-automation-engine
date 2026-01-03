trigger CaseAutomationTrigger on Case (after insert, after update) {
    Set<Id> caseIds = new Set<Id>();
    for (Case c : Trigger.new) {
        caseIds.add(c.Id);
    }
    CaseAutomationEnqueuer.enqueue(caseIds);
}
