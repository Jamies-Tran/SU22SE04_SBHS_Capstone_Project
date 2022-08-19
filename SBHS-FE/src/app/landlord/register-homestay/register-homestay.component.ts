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
import { Editor, Toolbar } from 'ngx-editor';

interface City {
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
  file!: File;
  payment = 'atm';
  value!: string;
  public homestayLicense!: string;
  public homestayImages: string[] = [];
  readonly = false;

  newServices: any[] = [];
  newFacility: any[] = [];

  // richtext
  editor!: Editor;
  html!: '';
  toolbar: Toolbar = [
    ['bold', 'italic'],
    ['underline', 'strike'],
    ['code', 'blockquote'],
    ['ordered_list', 'bullet_list'],
    [{ heading: ['h1', 'h2', 'h3', 'h4', 'h5', 'h6'] }],
    ['link', 'image'],
    ['text_color', 'background_color'],
    ['align_left', 'align_center', 'align_right', 'align_justify'],
  ];

  // new Facility
  addFacility() {
    this.newFacility.push({ name: '', amount: '', status: false });
    console.log('values', this.newFacility);
    console.log('size', this.newFacility.length);
  }

  removeFacility(i: any) {
    this.newFacility.splice(i, 1);
    console.log('delete',this.newFacility.length + i);
  }

  resetFacility(): void {
    this.newFacility = [];
    console.log(this.newFacility);
  }

  // New Service
  addService() {
    this.newServices.push({ name: '', price: '', status: false });
    console.log('values', this.newServices);
    console.log('size', this.newServices.length);
  }

  removeService(i: any) {
    this.newServices.splice(i, 1);
  }

  resetService(): void {
    this.newServices = [];
    console.log(this.newServices);
  }

  cities: City[] = [
    { value: 'TP.HCM' },
    { value: 'TP.Da Lat' },
    { value: 'TP.Ha Noi' },
    { value: 'Quang Nam' },
    { value: 'Vung Tau' },
    { value: 'TP.Da Nang' },
  ];

  informationFormGroup = this._formBuilder.group({
    homestayName: ['', Validators.required],
    address: ['', Validators.required],
    checkInTime: ['', Validators.required],
    checkOutTime: ['', Validators.required],
    price: ['', Validators.required],
    number: ['', Validators.required],
    city: ['', Validators.required],
    description: [''],

    image: [false, Validators.requiredTrue],
  });

  facilityFormGroup = this._formBuilder.group({
    tv: [false],
    inputTv: [{ value: '', disabled: true }],
    bed: false,
    inputBed: [{ value: '', disabled: true }],
    sofa: false,
    inputSofa: [{ value: '', disabled: true }],
    fan: false,
    inputFan: [{ value: '', disabled: true }],
    cookingStove: false,
    inputCookingStove: [{ value: '', disabled: true }],
    shower: false,
    inputShower: [{ value: '', disabled: true }],
    toilet: false,
    inputToilet: [{ value: '', disabled: true }],
    bathtub: false,
    inputBathtub: [{ value: '', disabled: true }],
  });

  enableInputTV() {
    if (this.facilityFormGroup.controls.tv.value === true) {
      this.facilityFormGroup.controls.inputTv.enable();
    } else {
      this.facilityFormGroup.controls.inputTv.disable();
      // this.facilityFormGroup.controls.inputTv.reset();
    }
  }
  enableInputBed() {
    if (this.facilityFormGroup.controls.bed.value === true) {
      this.facilityFormGroup.controls.inputBed.enable();
    } else {
      this.facilityFormGroup.controls.inputBed.disable();
      // this.facilityFormGroup.controls.inputTv.reset();
    }
  }
  enableInputSofa() {
    if (this.facilityFormGroup.controls.sofa.value === true) {
      this.facilityFormGroup.controls.inputSofa.enable();
    } else {
      this.facilityFormGroup.controls.inputSofa.disable();
      // this.facilityFormGroup.controls.inputTv.reset();
    }
  }
  enableInputFan() {
    if (this.facilityFormGroup.controls.fan.value === true) {
      this.facilityFormGroup.controls.inputFan.enable();
    } else {
      this.facilityFormGroup.controls.inputFan.disable();
      // this.facilityFormGroup.controls.inputTv.reset();
    }
  }
  enableInputCookingStove() {
    if (this.facilityFormGroup.controls.cookingStove.value === true) {
      this.facilityFormGroup.controls.inputCookingStove.enable();
    } else {
      this.facilityFormGroup.controls.inputCookingStove.disable();
      // this.facilityFormGroup.controls.inputTv.reset();
    }
  }
  enableInputShower() {
    if (this.facilityFormGroup.controls.shower.value === true) {
      this.facilityFormGroup.controls.inputShower.enable();
    } else {
      this.facilityFormGroup.controls.inputShower.disable();
      // this.facilityFormGroup.controls.inputTv.reset();
    }
  }
  enableInputToilet() {
    if (this.facilityFormGroup.controls.toilet.value === true) {
      this.facilityFormGroup.controls.inputToilet.enable();
    } else {
      this.facilityFormGroup.controls.inputToilet.disable();
      // this.facilityFormGroup.controls.inputTv.reset();
    }
  }
  enableInputBathub() {
    if (this.facilityFormGroup.controls.bathtub.value === true) {
      this.facilityFormGroup.controls.inputBathtub.enable();
    } else {
      this.facilityFormGroup.controls.inputBathtub.disable();
      // this.facilityFormGroup.controls.inputTv.reset();
    }
  }




  serviceFormGroup = this._formBuilder.group({
    wifi: false,
    wifiPrice: [{ value: '', disabled: true }],
    food: false,
    foodPrice: [{ value: '', disabled: true }],
    bar: false,
    barPrice: [{ value: '', disabled: true }],
    swimming: false,
    swimmingPrice: [{ value: '', disabled: true }],
    spa: false,
    spaPrice: [{ value: '', disabled: true }],
    fishing: false,
    fishingPrice: [{ value: '', disabled: true }],
    carRental: false,
    carRentalPrice: [{ value: '', disabled: true }],
    campfire: false,
    campfirePrice: [{ value: '', disabled: true }],
  });
  enableInputWifi() {
    if (this.serviceFormGroup.controls.wifi.value === true) {
      this.serviceFormGroup.controls.wifiPrice.enable();
    } else {
      this.serviceFormGroup.controls.wifiPrice.disable();
      // this.facilityFormGroup.controls.inputTv.reset();
    }
  }
  enableInputFood() {
    if (this.serviceFormGroup.controls.food.value === true) {
      this.serviceFormGroup.controls.foodPrice.enable();
    } else {
      this.serviceFormGroup.controls.foodPrice.disable();
      // this.facilityFormGroup.controls.inputTv.reset();
    }
  }
  enableInputBar() {
    if (this.serviceFormGroup.controls.bar.value === true) {
      this.serviceFormGroup.controls.barPrice.enable();
    } else {
      this.serviceFormGroup.controls.barPrice.disable();
      // this.facilityFormGroup.controls.inputTv.reset();
    }
  }
  enableInputSwimming() {
    if (this.serviceFormGroup.controls.swimming.value === true) {
      this.serviceFormGroup.controls.swimmingPrice.enable();
    } else {
      this.serviceFormGroup.controls.swimmingPrice.disable();
      // this.facilityFormGroup.controls.inputTv.reset();
    }
  }
  enableInputSpa() {
    if (this.serviceFormGroup.controls.spa.value === true) {
      this.serviceFormGroup.controls.spaPrice.enable();
    } else {
      this.serviceFormGroup.controls.spaPrice.disable();
      // this.facilityFormGroup.controls.inputTv.reset();
    }
  }
  enableInputFishing() {
    if (this.serviceFormGroup.controls.fishing.value === true) {
      this.serviceFormGroup.controls.fishingPrice.enable();
    } else {
      this.serviceFormGroup.controls.fishingPrice.disable();
      // this.facilityFormGroup.controls.inputTv.reset();
    }
  }
  enableInputCarRental() {
    if (this.serviceFormGroup.controls.carRental.value === true) {
      this.serviceFormGroup.controls.carRentalPrice.enable();
    } else {
      this.serviceFormGroup.controls.carRentalPrice.disable();
      // this.facilityFormGroup.controls.inputTv.reset();
    }
  }
  enableInputCampFire() {
    if (this.serviceFormGroup.controls.campfire.value === true) {
      this.serviceFormGroup.controls.campfirePrice.enable();
    } else {
      this.serviceFormGroup.controls.campfirePrice.disable();
      // this.facilityFormGroup.controls.inputTv.reset();
    }
  }


  paymentFormGroup = this._formBuilder.group({});
  registerError: string = '';

  constructor(
    private _formBuilder: FormBuilder,
    private http: ServerHttpService,
    private router: Router,
    private route: ActivatedRoute,
    private storage: AngularFireStorage,
    private db: AngularFirestore
  ) {}
    ListSpecialDay :any
  ngOnInit(): void {
    this.editor = new Editor();
    this.http.getSpecialDay().subscribe((data =>{
      this.ListSpecialDay = data
      console.log(data)
    }))
  }

  ngOnDestroy(): void {
    this.editor.destroy();
  }

  // lấy file hình
  onSelectImageHomestay(files: any) {
    console.log('onselect: ', files);
    // set files
    this.homestayImageFiles.push(...files.addedFiles);
    if (
      this.homestayImageFiles.length >= 1 &&
      this.homestayLicenseFiles.length == 1
    ) {
      this.informationFormGroup.patchValue({ image: true });
    } else {
      this.informationFormGroup.patchValue({ image: false });
    }
  }

  // xóa file hình
  onRemoveHomestayImage(event: File) {
    console.log(event);
    this.homestayImageFiles.splice(this.homestayImageFiles.indexOf(event), 1);
    console.log('xoa file:', this.homestayImageFiles);
    if (
      this.homestayImageFiles.length >= 1 &&
      this.homestayLicenseFiles.length == 1
    ) {
      this.informationFormGroup.patchValue({ image: true });
    } else {
      this.informationFormGroup.patchValue({ image: false });
    }
  }

  // lấy file hình
  onSelectHomestayLicense(files: any) {
    console.log('onselect: ', files);
    // set files
    this.homestayLicenseFiles.push(...files.addedFiles);
    console.log('file array', this.homestayLicenseFiles);
    console.log('file lenght', this.homestayLicenseFiles.length);

    if (this.homestayLicenseFiles.length > 1) {
      this.homestayLicenseFiles.splice(
        this.homestayLicenseFiles.indexOf(files),
        1
      );
      console.log('file lenght slice', this.homestayLicenseFiles.length);
      console.log('file array', this.homestayLicenseFiles);
      console.log('file index', this.homestayLicenseFiles.indexOf(files));
    }
    if (
      this.homestayImageFiles.length >= 1 &&
      this.homestayLicenseFiles.length == 1
    ) {
      this.informationFormGroup.patchValue({ image: true });
    } else {
      this.informationFormGroup.patchValue({ image: false });
    }
  }

  // xóa file hình
  onRemoveHomestayLicense(event: File) {
    console.log(event);
    console.log('xoa index:', this.homestayLicenseFiles.indexOf(event));
    this.homestayLicenseFiles.splice(
      this.homestayLicenseFiles.indexOf(event),
      1
    );
    console.log('xoa file:', this.homestayLicenseFiles);
    if (
      this.homestayImageFiles.length >= 1 &&
      this.homestayLicenseFiles.length == 1
    ) {
      this.informationFormGroup.patchValue({ image: true });
    } else {
      this.informationFormGroup.patchValue({ image: false });
    }
  }

  informationForm() {
    console.log(this.informationFormGroup.value);
    // console.log("homestay license", this.homestayLicense);
    console.log('homestay image', this.homestayImages);
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
    console.log('register');
    for (this.file of this.homestayImageFiles) {
      console.log('file homestayimage name:', this.file.name);
      const path = 'homestay/' + this.file.name;
      const fileRef = this.storage.ref(path);
      this.storage.upload(path, this.file);

      this.homestayImages.push(this.file.name);
      console.log('ten file luu tren database', this.homestayImages);
    }

    // homestayLicenseFiles
    for (this.file of this.homestayLicenseFiles) {
      console.log('file homestay license name:', this.file.name);
      const path = 'license/' + this.file.name;
      const fileRef = this.storage.ref(path);
      this.storage.upload(path, this.file);

      this.homestayLicense = this.file.name;
      console.log('ten file luu tren database', this.homestayLicense);
    }

    // lay value
    const formInformationFormGroupValue = this.informationFormGroup.controls;
    let homestayName = formInformationFormGroupValue.homestayName.value!;
    let price = formInformationFormGroupValue.price.value!;
    let address = formInformationFormGroupValue.address.value!;
    let city = formInformationFormGroupValue.city.value!;
    let checkInTime = formInformationFormGroupValue.checkInTime.value!;
    let checkOutTIme = formInformationFormGroupValue.checkOutTime.value!;
    let numberOfRoom = formInformationFormGroupValue.number.value!;
    let description = formInformationFormGroupValue.description.value!;

    const facilityFormGroupValue = this.facilityFormGroup.controls;
    type homestayFacilities = Array<{ name: string; amount: string }>;
    const myhomestayFacilities: homestayFacilities = [];

    // Add new service
    for (let value of this.newFacility) {
      if (value.status) {
        console.log('value facility true', value);
        myhomestayFacilities.push({
          name: value.name,
          amount: value.amount,
        });
        console.log(' myHomestayFacility.push', myhomestayFacilities);
      }
    }

    if (facilityFormGroupValue.tv.value == true) {
      myhomestayFacilities.push({
        name: 'TV',
        amount: facilityFormGroupValue.inputTv.value + '',
      });
    }

    if (facilityFormGroupValue.cookingStove.value == true) {
      myhomestayFacilities.push({
        name: 'cookingStove',
        amount: facilityFormGroupValue.inputCookingStove.value + '',
      });
    }

    if (facilityFormGroupValue.bed.value == true) {
      myhomestayFacilities.push({
        name: 'bed',
        amount: facilityFormGroupValue.inputBed.value + '',
      });
    }

    if (facilityFormGroupValue.shower.value == true) {
      myhomestayFacilities.push({
        name: 'shower',
        amount: facilityFormGroupValue.inputShower.value + '',
      });
    }

    if (facilityFormGroupValue.sofa.value == true) {
      myhomestayFacilities.push({
        name: 'sofa',
        amount: facilityFormGroupValue.inputSofa.value + '',
      });
    }

    if (facilityFormGroupValue.toilet.value == true) {
      myhomestayFacilities.push({
        name: 'toilet',
        amount: facilityFormGroupValue.inputToilet.value + '',
      });
    }

    if (facilityFormGroupValue.fan.value == true) {
      myhomestayFacilities.push({
        name: 'fan',
        amount: facilityFormGroupValue.inputFan.value + '',
      });
    }

    if (facilityFormGroupValue.bathtub.value == true) {
      myhomestayFacilities.push({
        name: 'bathtub',
        amount: facilityFormGroupValue.inputBathtub.value + '',
      });
    }

    console.log(myhomestayFacilities);

    const serviceFormGroupValue = this.serviceFormGroup.controls;
    type homestayServices = Array<{ name: string; price: string }>;
    const myHomestayServices: homestayServices = [];

    // Add new service
    for (let value of this.newServices) {
      if (value.status) {
        console.log('value service true', value);
        myHomestayServices.push({
          name: value.name,
          price: value.price,
        });
        console.log(' myHomestayServices.push', myHomestayServices);
      }
    }

    if (serviceFormGroupValue.wifi.value == true) {
      myHomestayServices.push({
        name: 'wifi',
        price: serviceFormGroupValue.wifiPrice.value + '',
      });
    }

    if (serviceFormGroupValue.spa.value == true) {
      myHomestayServices.push({
        name: 'spa',
        price: serviceFormGroupValue.spaPrice.value + '',
      });
    }

    if (serviceFormGroupValue.food.value == true) {
      myHomestayServices.push({
        name: 'food',
        price: serviceFormGroupValue.foodPrice.value + '',
      });
    }

    if (serviceFormGroupValue.fishing.value == true) {
      myHomestayServices.push({
        name: 'fishing',
        price: serviceFormGroupValue.fishingPrice.value + '',
      });
    }

    if (serviceFormGroupValue.bar.value == true) {
      myHomestayServices.push({
        name: 'bar',
        price: serviceFormGroupValue.barPrice.value + '',
      });
    }

    if (serviceFormGroupValue.carRental.value == true) {
      myHomestayServices.push({
        name: 'carRental',
        price: serviceFormGroupValue.carRentalPrice.value + '',
      });
    }

    if (serviceFormGroupValue.swimming.value == true) {
      myHomestayServices.push({
        name: 'swimming',
        price: serviceFormGroupValue.swimmingPrice.value + '',
      });
    }

    if (serviceFormGroupValue.campfire.value == true) {
      myHomestayServices.push({
        name: 'campfire',
        price: serviceFormGroupValue.campfirePrice.value + '',
      });
    }

    type homestayImages = Array<{ url: string }>;
    const myHomestayimages: homestayImages = [];
    //  =[{url:this.homestayImages}];
    for (let i of this.homestayImages) {
      myHomestayimages.push({ url: i.toString() });
      console.log('submit: ', i);
    }
    type homestayLicenses = { url: string };
    const myHomestayLicenses: homestayLicenses = { url: this.homestayLicense };
    console.log(this.homestayImages);

    // api
    this.http
      .registerLandlord(
        homestayName,
        description,
        address,
        city,
        price,
        numberOfRoom,
        checkInTime,
        checkOutTIme,
        this.payment,
        myHomestayLicenses,
        myHomestayimages,
        myHomestayServices,
        myhomestayFacilities
      )
      .subscribe(
        (data) => {
          alert('Register Success!!!');
        },
        (error) => {
          if (error['status'] == 500) {
            this.registerError = 'please check your information again!';
          } else this.registerError = error;
        }
      );
  }
}
