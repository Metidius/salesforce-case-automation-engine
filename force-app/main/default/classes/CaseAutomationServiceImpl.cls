public with sharing class CaseAutomationServiceImpl implements ICaseAutomationService {

    private fflib_ISObjectUnitOfWork uow() {
        return SFDC_Application.UnitOfWork.newInstance(
            new List<Schema.SObjectType>{
                Case.SObjectType,
                AutomationLog__c.SObjectType
            }
        );
    }

    public void processCases(Set<Id> caseIds) {
        if (caseIds == null || caseIds.isEmpty()) return;

        List<Case> cases = AutomationCasesSelector.newInstance().selectById(caseIds);
        if (cases.isEmpty()) return;

        // Fingerprint = simple idempotency key (caseId + lastModified)
        Set<String> fingerprints = new Set<String>();
        Map<Id, String> caseIdToFingerprint = new Map<Id, String>();

        for (Case c : cases) {
            String fp = String.valueOf(c.Id) + '|' + String.valueOf(c.LastModifiedDate);
            fingerprints.add(fp);
            caseIdToFingerprint.put(c.Id, fp);
        }

        // Check what's already processed
        List<AutomationLog__c> existing = AutomationLogsSelector.newInstance().selectByFingerprint(fingerprints);
        Set<String> alreadyDone = new Set<String>();
        for (AutomationLog__c log : existing) {
            alreadyDone.add(log.Fingerprint__c);
        }

        fflib_ISObjectUnitOfWork uow = uow();

        for (Case c : cases) {
            String fp = caseIdToFingerprint.get(c.Id);

            if (alreadyDone.contains(fp)) {
                uow.registerNew(new AutomationLog__c(
                    RelatedCase__c = c.Id,
                    Fingerprint__c = fp,
                    Status__c = 'Skipped',
                    Attempt__c = 1,
                    ProcessedAt__c = System.now(),
                    Message__c = 'Skipped (already processed for this fingerprint).'
                ));
                continue;
            }

            // Simulated "integration/enrichment"
            uow.registerNew(new AutomationLog__c(
                RelatedCase__c = c.Id,
                Fingerprint__c = fp,
                Status__c = 'Success',
                Attempt__c = 1,
                ProcessedAt__c = System.now(),
                Message__c = 'Processed successfully (simulated).'
            ));
        }

        uow.commitWork();
    }
}
