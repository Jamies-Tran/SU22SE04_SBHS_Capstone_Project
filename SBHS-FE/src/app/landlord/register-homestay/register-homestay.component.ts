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
    note: [''],
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


    this.http.registerLandlord(homestayName, address,price,this.payment ).subscribe((data => {
      console.log(data)

    }),
    error =>{
      alert(error)
    })
  }
}
