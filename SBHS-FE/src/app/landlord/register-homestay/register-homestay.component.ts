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

@Component({
  selector: 'app-register-homestay',
  templateUrl: './register-homestay.component.html',
  styleUrls: ['./register-homestay.component.scss'],
})
export class RegisterHomestayComponent implements OnInit {
  files: File[] = [];
  file!:File;
  payment=  "atm" ;

  informationFormGroup = this._formBuilder.group({
    homestayName: ['', Validators.required],
    address: ['', Validators.required],
    checkInTime: ['', Validators.required],
    checkOutTime: ['', Validators.required],
    price: ['', Validators.required],
    number: ['', Validators.required],
    city: [''],
    description: [''],
    fileSource: [this.files.toString],
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
  onSelect(files: any) {
    console.log('onselect: ', files);
    // set files
    this.files.push(...files.addedFiles);


    // upload image len firebase
    //  chuyen code nay sang submit
    for(this.file of this.files){
      console.log('file name:',  this.file.name);
      const path = "homestay/" + this.file.name;
      this.storage.upload( path ,this.file);
      console.log('starupload: ', this.storage);
    }
  }

  // xóa file hình
  onRemove(event: File) {
    console.log(event);
    this.files.splice(this.files.indexOf(event), 1);
    console.log('xoa file:', this.files.indexOf(event));
  }

  informationForm() {
    console.log(this.informationFormGroup.value);
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
// api
    this.http.registerLandlord(homestayName, address,city,price,this.payment,myHomestayServices, myhomestayFacilities).subscribe((data => {
      alert('Register Success!!!')
    }),
    error =>{
      alert(error)
    })
  }
}
