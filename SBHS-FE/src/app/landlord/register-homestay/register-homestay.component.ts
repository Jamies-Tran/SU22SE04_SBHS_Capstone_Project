import { Component, OnInit } from '@angular/core';
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
  payment=  "atm" ;
  public name = "";
  public location = "";
  public price ="";
  informationFormGroup = this._formBuilder.group({
    homestayName: ['', Validators.required],
    address: ['', Validators.required],
    checkInTime: ['', Validators.required],
    checkOutTime: ['', Validators.required],
    price: ['', Validators.required],
    number: ['', Validators.required],
    note: [''],
    description: [''],
    fileSource: [this.files],
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

  constructor(private _formBuilder: FormBuilder, private http: ServerHttpService, private router: Router,private route: ActivatedRoute) {}

  ngOnInit(): void {}

  onSelect(event: any) {
    console.log(event);
    this.files.push(...event.addedFiles);
  }

  onRemove(event: File) {
    console.log(event);
    this.files.splice(this.files.indexOf(event), 1);
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
    this.http.registerLandlord(this.name, this.location,this.price,this.payment).subscribe((data => {
      console.log(data)

    }))
  }
}
