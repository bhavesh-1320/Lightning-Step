<aura:application extends="force:slds">
    <aura:attribute name="selectRecordId1" type="String"/>
    <aura:attribute name="selectRecordName1" type="String"/>
    
    <aura:attribute name="selectRecordId2" type="String"/>
    <aura:attribute name="selectRecordName2" type="String"/>
    
    <aura:attribute name="selectRecordId3" type="String"/>
    <aura:attribute name="selectRecordName3" type="String"/>
    
    <aura:attribute name="selectRecordId4" type="String"/>
    <aura:attribute name="selectRecordName4" type="String"/>

    <div class="c-container">
        <lightning:layout >
            <lightning:layoutItem padding="around-small">
                <c:ShowUserLookup objectName="User" fieldName="Name" Label="Owner Id" 
                             selectRecordId="{!v.selectRecordId1}" selectRecordName="{!v.selectRecordName1}" 
                             required="false" iconName="action:user"/>
               <p>Selected Record Id: {!v.selectRecordId1}</p> 
               <p>Selected Record Name: {!v.selectRecordName1}</p>
            </lightning:layoutItem>
            <lightning:layoutItem padding="around-small">
                <c:ShowUserLookup objectName="Account" fieldName="Name" Label="Account name" 
                             selectRecordId="{!v.selectRecordId2}" selectRecordName="{!v.selectRecordName2}" 
                             required="false" iconName="action:new_account"/>
                <p>Selected Record Id: {!v.selectRecordId2}</p> 
               <p>Selected Record Name: {!v.selectRecordName2}</p>
            </lightning:layoutItem>
            <lightning:layoutItem padding="around-small">
                <c:ShowUserLookup objectName="Contact" fieldName="Name" Label="Contact name" 
                             selectRecordId="{!v.selectRecordId3}" selectRecordName="{!v.selectRecordName3}" 
                             required="false" iconName="action:new_contact"/>
                <p>Selected Record Id: {!v.selectRecordId3}</p> 
               <p>Selected Record Name: {!v.selectRecordName3}</p>
            </lightning:layoutItem>
            <lightning:layoutItem padding="around-small">
                <c:ShowUserLookup objectName="Account" fieldName="Name" Label="Account name" 
                             selectRecordId="{!v.selectRecordId4}" selectRecordName="{!v.selectRecordName4}" 
                             required="false" iconName="action:new_account"/>
                <p>Selected Record Id: {!v.selectRecordId4}</p> 
               <p>Selected Record Name: {!v.selectRecordName4}</p>
            </lightning:layoutItem>
        </lightning:layout>
    </div>
</aura:application>