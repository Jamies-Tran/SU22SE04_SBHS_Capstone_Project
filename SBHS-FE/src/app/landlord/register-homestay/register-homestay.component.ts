import { Component, OnInit } from '@angular/core';
import { AngularFirestore } from '@angular/fire/compat/firestore';
import { AngularFireStorage } from '@angular/fire/compat/storage';
import {
  FormBuilder,
  Validators,
  FormGroup,
  FormControl,
} from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ServerHttpService } from 'src/app/services/register-homestay.service';
import { finalize } from 'rxjs/operators';
import { Observable } from 'rxjs';




interface City{
  value: string;

}
@Component({
  selector: 'app-register-homestay',
  templateUrl: './register-homestay.component.html',
  styleUrls: ['./register-homestay.component.scss'],
})
export class RegisterHomestayComponent implements OnInit {
  homestayImageFiles: File[] = [];
  homestayLicenseFiles: File[] = [];
  file!:File;
  payment=  "atm" ;
  value!: string;
  public homestayLicense !: string;
  public homestayImages : string[]=[];


  cities:City[] = [
    {value:'TP.HCM'},
    {value:'TP.Da Lat'},
    {value:'TP.Ha Noi'},
    {value:'Quang Nam'},
    {value:'Vung Tau'},
    {value:'TP.Da Nang'},
  ]

  informationFormGroup = this._formBuilder.group({
    homestayName: ['', Validators.required],
    address: ['', Validators.required],
    checkInTime: ['', Validators.required],
    checkOutTime: ['', Validators.required],
    price: ['', Validators.required],
    number: ['', Validators.required],
    city: ['', Validators.required],
    description: [''],

    image: [false, Validators.requiredTrue]
  });




  facilityFormGroup = this._formBuilder.group({
    tv: false,
    inputTv: [''],
    bed: false,
    inputBed:[''],
    sofa:false,
    inputSofa:[''],
    fan:false,
    inputFan:[''],
    cookingStove:false,
    inputCookingStove:[''],
    shower:false,
    inputShower:[''],
    toilet:false,
    inputToilet:[''],
    bathtub:false,
    inputBathtub:[''],

  });

  serviceFormGroup = this._formBuilder.group({
    wifi:false,
    wifiPrice:[''],
    food:false,
    foodPrice:[''],
    bar:false,
    barPrice:[''],
    swimming:false,
    swimmingPrice:[''],
    spa:false,
    spaPrice:[''],
    fishing:false,
    fishingPrice:[''],
    carRental:false,
    carRentalPrice:[''],
    campfire:false,
    campfirePrice:['']
  });

  paymentFormGroup = this._formBuilder.group({});

  constructor(
    private _formBuilder: FormBuilder,
    private http: ServerHttpService,
    private router: Router,
    private route: ActivatedRoute,
    private storage: AngularFireStorage ,
    private db: AngularFirestore) {}

  ngOnInit(): void {

  }




  // lấy file hình
  onSelectImageHomestay(files: any) {
    console.log('onselect: ', files);
    // set files
    this.homestayImageFiles.push(...files.addedFiles);
    if(this.homestayImageFiles.length>=1 && this.homestayLicenseFiles.length==1){

      this.informationFormGroup.patchValue({image:true});
    }else{
      this.informationFormGroup.patchValue({image:false});
    }

  }

  // xóa file hình
  onRemoveHomestayImage(event: File) {
    console.log(event);
    this.homestayImageFiles.splice(this.homestayImageFiles.indexOf(event), 1);
    console.log('xoa file:', this.homestayImageFiles);
    if(this.homestayImageFiles.length>=1 && this.homestayLicenseFiles.length==1){

      this.informationFormGroup.patchValue({image:true});
    }else{
      this.informationFormGroup.patchValue({image:false});
    }
  }


  // lấy file hình
  onSelectHomestayLicense(files: any) {
    console.log('onselect: ', files);
    // set files
    this.homestayLicenseFiles.push(...files.addedFiles);
    console.log('file array', this.homestayLicenseFiles);
    console.log('file lenght' , this.homestayLicenseFiles.length);

    if(this.homestayLicenseFiles.length>1){
      this.homestayLicenseFiles.splice(this.homestayLicenseFiles.indexOf(files),1);
      console.log('file lenght slice' , this.homestayLicenseFiles.length);
      console.log('file array', this.homestayLicenseFiles);
      console.log('file index', this.homestayLicenseFiles.indexOf(files));

    }
    if(this.homestayImageFiles.length>=1 && this.homestayLicenseFiles.length==1){

      this.informationFormGroup.patchValue({image:true});
    }else{
      this.informationFormGroup.patchValue({image:false});
    }



  }

  // xóa file hình
  onRemoveHomestayLicense(event: File) {
    console.log(event);
    console.log('xoa index:', this.homestayLicenseFiles.indexOf(event));
    this.homestayLicenseFiles.splice(this.homestayLicenseFiles.indexOf(event), 1);
    console.log('xoa file:', this.homestayLicenseFiles);
    if(this.homestayImageFiles.length>=1 && this.homestayLicenseFiles.length==1){

      this.informationFormGroup.patchValue({image:true});
    }else{
      this.informationFormGroup.patchValue({image:false});
    }

  }



  informationForm() {
    console.log(this.informationFormGroup.value);
    // console.log("homestay license", this.homestayLicense);
    console.log("homestay image", this.homestayImages);
  }
  facilityForm() {
    console.log(this.facilityFormGroup.value);
  }
  serviceForm() {
    console.log(this.serviceFormGroup.value);
  }
  paymentForm() {
    console.log(this.paymentFormGroup.value);
  }



  public register() {

    for(this.file of this.homestayImageFiles){
      console.log('file homestayimage name:',  this.file.name);
      const path = "homestay/" + this.file.name;
      const fileRef = this.storage.ref( path );
      this.storage.upload( path ,this.file);


      this.homestayImages.push(this.file.name);
      console.log("ten file luu tren database", this.homestayImages);

    }

    // homestayLicenseFiles
    for(this.file of this.homestayLicenseFiles){
      console.log('file homestay license name:',  this.file.name);
      const path = "license/" + this.file.name;
      const fileRef = this.storage.ref( path );
      this.storage.upload( path ,this.file);


      this.homestayLicense = this.file.name;
      console.log("ten file luu tren database", this.homestayLicense);

    }

// lay value
    const formInformationFormGroupValue = this.informationFormGroup.controls;
    let homestayName = formInformationFormGroupValue.homestayName.value!;
    let price = formInformationFormGroupValue.price.value!;
    let address = formInformationFormGroupValue.address.value!;
    let city = formInformationFormGroupValue.city.value!;
    const facilityFormGroupValue = this.facilityFormGroup.controls;
    type homestayFacilities= Array<{name: string ,amount: string}>;
    const myhomestayFacilities:homestayFacilities =[];

    if(facilityFormGroupValue.tv.value == true){
      myhomestayFacilities.push({name:"TV",amount:facilityFormGroupValue.inputTv.value+""})
    }

    if(facilityFormGroupValue.cookingStove.value == true){
      myhomestayFacilities.push({name:"cookingStove",amount:facilityFormGroupValue.inputCookingStove.value+""})
    }

    if(facilityFormGroupValue.bed.value == true){
      myhomestayFacilities.push({name:"bed",amount:facilityFormGroupValue.inputBed.value+""})
    }

    if(facilityFormGroupValue.shower.value == true){
      myhomestayFacilities.push({name:"shower",amount:facilityFormGroupValue.inputShower.value+""})
    }

    if(facilityFormGroupValue.sofa.value == true){
      myhomestayFacilities.push({name:"sofa",amount:facilityFormGroupValue.inputSofa.value+""})
    }

    if(facilityFormGroupValue.toilet.value == true){
      myhomestayFacilities.push({name:"toilet",amount:facilityFormGroupValue.inputToilet.value+""})
    }

    if(facilityFormGroupValue.fan.value == true){
      myhomestayFacilities.push({name:"fan",amount:facilityFormGroupValue.inputFan.value+""})
    }

    if(facilityFormGroupValue.bathtub.value == true){
      myhomestayFacilities.push({name:"bathtub",amount:facilityFormGroupValue.inputBathtub.value+""})
    }

    console.log(myhomestayFacilities)

    const serviceFormGroupValue = this.serviceFormGroup.controls;
    type homestayServices = Array<{name: string ,price: string}>;
    const myHomestayServices:homestayServices =[];

    if(serviceFormGroupValue.wifi.value == true){
      myHomestayServices.push({name:"wifi",price:serviceFormGroupValue.wifiPrice.value+""})
    }

    if(serviceFormGroupValue.spa.value == true){
      myHomestayServices.push({name:"spa",price:serviceFormGroupValue.spaPrice.value+""})
    }

    if(serviceFormGroupValue.food.value == true){
      myHomestayServices.push({name:"food",price:serviceFormGroupValue.foodPrice.value+""})
    }

    if(serviceFormGroupValue.fishing.value == true){
      myHomestayServices.push({name:"fishing",price:serviceFormGroupValue.fishingPrice.value+""})
    }

    if(serviceFormGroupValue.bar.value == true){
      myHomestayServices.push({name:"bar",price:serviceFormGroupValue.barPrice.value+""})
    }

    if(serviceFormGroupValue.carRental.value == true){
      myHomestayServices.push({name:"carRental",price:serviceFormGroupValue.carRentalPrice.value+""})
    }

    if(serviceFormGroupValue.swimming.value == true){
      myHomestayServices.push({name:"swimming",price:serviceFormGroupValue.swimmingPrice.value+""})
    }

    if(serviceFormGroupValue.campfire.value == true){
      myHomestayServices.push({name:"campfire",price:serviceFormGroupValue.campfirePrice.value+""})
    }

    type homestayImages = Array<{url: string }>;
    const myHomestayimages:homestayImages =[];
    //  =[{url:this.homestayImages}];
    for(let i of this.homestayImages ){
      myHomestayimages.push({url:i.toString()});
      console.log( "submit: ",i);
    }
    type homestayLicenses = {url:string};
    const myHomestayLicenses:homestayLicenses = {url:this.homestayLicense};
    console.log(this.homestayImages);

// api
    this.http.registerLandlord(homestayName, address,city,price,this.payment,myHomestayLicenses,myHomestayimages,myHomestayServices, myhomestayFacilities).subscribe((data => {
      alert('Register Success!!!')
    }),
    error =>{
      alert(error)
    })
  }
}
