import { LightningElement , wire,track, api } from 'lwc';
import getCountryPicklistValues from '@salesforce/apex/CountryInformationController.getPicklistValues';
import getCountryInformation from '@salesforce/apex/CountryInformationController.getCountryInformation';
import getData from '@salesforce/apex/CountryInformationController.getData';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

export default class CountryInformation extends LightningElement {
    @track columns = [{
        label: 'Country',
        fieldName: 'Country_Abbreviation__c',
        type: 'text',
        sortable: true
    },
    {
        label: 'Country Abbreviation',
        fieldName: 'Country__c',
        type: 'text',
        sortable: true
    },
    {
        label: 'Postal Code',
        fieldName: 'Postal_Code__c',
        type: 'text',
        sortable: true
    },{
        label: 'Latitude',
        fieldName: 'Latitude__c',
        type: 'text',
        sortable: true
    },
    {
        label: 'Longitude',
        fieldName: 'Longitude__c',
        type: 'text',
        sortable: true
    },
    {
        label: 'Place Name',
        fieldName: 'Place_Name__c',
        type: 'text',
        sortable: true
    },
    {
        label: 'State',
        fieldName: 'State__c',
        type: 'text',
        sortable: true
    },
    {
        label: 'State Abbreviation',
        fieldName: 'State_Abbreviation__c',
        type: 'text',
        sortable: true
    }
];
    @track countryOptions; 
    country;
    zipCode;
    @track countryDta;
    @api countryinfo;
    _wiredResult;
    @wire(getCountryPicklistValues, {})
    wiredCountryPicklistValues({ error, data }) {
        if (data) {
            this.countryOptions = data.map(option => {
                return {
                    label: option.label,
                    value: option.value
                };
            });
            this.displayCountryInformation();
        }
        else if (error) {
            console.error(error);
        }
    }

    @wire(getData, {})
    wiredCallback({ error, data }) {
        this._wiredResult = data;
        if (data) {
            this.countryDta=this._wiredResult;
        } else {
            console.error(error);
        }
    }
     sendInformation() {
        this.zipCode = this.template.querySelector('lightning-input[data-name="ZipCode"]').value.toUpperCase();
        console.log(this.zipCode);
        this.country = this.template.querySelector('lightning-combobox[data-name="country"]').value.toUpperCase();
        console.log(this.country);
            getCountryInformation({country:this.country,zipCode:this.zipCode})
            .then((result) =>{
                this.countryInfo=result;
                console.log(JSON.stringify(result));
                this.template.querySelector("c-country-information-child").setinfocoun(result);
            if (this.countryInfo.postCode!=undefined) {
                if(this.countryInfo.countryAbbreviation !='US'){
                this.showToastMsg('success', 'Process Completed,The  data is available in Country Information Table', 'dismissable');
                }else{
                    this.showToastMsg('success', 'Process Completed, The data is available in Country Information US table', 'dismissable');
                    }
                } else {
                    this.showToastMsg('error', 'No data found with '+this.zipCode+'zip code', 'dismissable');
                }
                this.template.querySelector('lightning-combobox[data-name="country"]').value='';
                this.template.querySelector('lightning-input[data-name="ZipCode"]').value='';
        }).catch(error => {
            const message = 'Error received: code' + error.errorCode + ', ' +
                'message ' + error.body.message;
            console.error(message);
        });
         this.displayCountryInformation();
    }

    displayCountryInformation(){
        return refreshApex(this._wiredResult);
    }

    showToastMsg(msgtype, msg, modeType){
        const evt = new ShowToastEvent({
            title : '',
            variant : msgtype,
            message : msg,
            mode : modeType,
        });
        this.dispatchEvent(evt);
    }
    

}