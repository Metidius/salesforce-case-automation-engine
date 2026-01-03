public virtual class AutomationCasesSelector extends fflib_SObjectSelector {

    public static AutomationCasesSelector newInstance() {
        return (AutomationCasesSelector) SFDC_Application.Selector.newInstance(Case.SObjectType);
    }

    public Schema.SObjectType getSObjectType() {
        return Case.SObjectType;
    }

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
            Case.Id,
            Case.CaseNumber,
            Case.Status,
            Case.Priority,
            Case.Subject,
            Case.LastModifiedDate
        };
    }

    public List<Case> selectById(Set<Id> caseIds) {
        if (caseIds == null || caseIds.isEmpty()) return new List<Case>();
        return (List<Case>) selectSObjectsById(caseIds);
    }
}