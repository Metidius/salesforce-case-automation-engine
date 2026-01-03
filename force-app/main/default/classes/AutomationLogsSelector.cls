public virtual class AutomationLogsSelector extends fflib_SObjectSelector {

    public static AutomationLogsSelector newInstance() {
        return (AutomationLogsSelector) SFDC_Application.Selector.newInstance(AutomationLog__c.SObjectType);
    }

    public Schema.SObjectType getSObjectType() {
        return AutomationLog__c.SObjectType;
    }

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
            AutomationLog__c.Id,
            AutomationLog__c.RelatedCase__c,
            AutomationLog__c.Fingerprint__c,
            AutomationLog__c.Status__c,
            AutomationLog__c.Attempt__c,
            AutomationLog__c.ProcessedAt__c
        };
    }

    public List<AutomationLog__c> selectByFingerprint(Set<String> fingerprints) {
        if (fingerprints == null || fingerprints.isEmpty()) return new List<AutomationLog__c>();

        fflib_QueryFactory qf = newQueryFactory();
        qf.setCondition('Fingerprint__c IN :fingerprints');
        return (List<AutomationLog__c>) Database.query(qf.toSOQL());
    }
}