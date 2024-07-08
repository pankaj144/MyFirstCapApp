using { anubhav.db.master, anubhav.db.transaction } from '../db/datamodel';
using { cappo.cds } from '../db/CDSViews';
 
service CatalogService @(path:'CatalogService', requires:
'authenticated-user') {
 
    entity EmployeeSet @(restrict: [
                        { grant: ['READ'], to: 'Viewer', where: 'bankName = $user.BankName' },
                        { grant: ['WRITE'], to: 'Admin' }
                        ]) as projection on master.employees;
    
    entity AddressSet as projection on master.address;
    entity BusinessPartnerSet as projection on master.businesspartner;
    entity ProductSet as projection on master.product;

    entity POs @(odata.draft.enabled: true, restrict: [ { grant: ['WRITE'], to:'Admin'} ]) as projection on transaction.purchaseorder{
        *,
        Items,
        case OVERALL_STATUS
            when 'P' then 'Paid'
            when 'A' then 'Approved'
            when 'X' then 'Rejected'
            when 'N' then 'New'
            end as OverallStatus: String(10),
        @UI.Hidden: true
        case OVERALL_STATUS
            when 'P' then 3
            when 'A' then 3
            when 'X' then 1
            when 'N' then 2
            end as ColorCode: Integer
    }
    actions{
        @Common : { SideEffects : {
            $Type : 'Common.SideEffectsType',
            TargetProperties : [
                'in/GROSS_AMOUNT',
                'in/OverallStatus'
            ],
        }, }
        action boost();
        action setOrderProcessing();
    };

    function getOrderDefaults() returns POs; //get default values

    function getLargestOrder() returns POs;
    
    entity POItems as projection on transaction.poitems;



    //entity ProductCDS as projection on cds.CDSViews.ProductView;
    
    //entity POs as projection on transaction.purchaseorder;
   // entity POItems as projection on transaction.poitems;
    
    // CDS View Entity 
    //  entity ProductCDS as projection on cds.CDSViews.ProductView{
    //     *,
    //     To_Items
    // };
    // entity ItemView as projection on cds.CDSViews.ItemView;

    // entity POs as projection on transaction.purchaseorder{
    //     *,
    //     Items
    // }
    // actions{
    //     action boost();
    // };

    
}

// using { anubhav.db.master, anubhav.db.transaction } from '../db/datamodel';
 
// service CatalogService @(path:'CatalogService') {
 
//     entity EmployeeSet as projection on master.employees;
 
// }