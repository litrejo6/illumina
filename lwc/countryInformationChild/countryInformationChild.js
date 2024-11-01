import { LightningElement , api } from 'lwc';

export default class CountryInformationChild extends LightningElement {
    @api infocoun=null; 
    isShowing=false
    
    @api setinfocoun(infocoun) {
        if(infocoun !=null &&  infocoun.countryAbbreviation=='US'){
            this.isShowing=true;
        }
        this.infocoun = infocoun;
    }

    constructor() {
        super();
        if(this.infocoun==null  ){
            this.isShowing=false;
        }
        console.log('Constructor');
    }
    

}