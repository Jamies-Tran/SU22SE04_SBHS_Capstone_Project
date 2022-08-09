import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Route, Router } from '@angular/router';
import { ServerHttpService } from '../services/register.service';
import { AngularFireStorage } from '@angular/fire/compat/storage';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss'],
})
export class RegisterComponent implements OnInit {
  registerError: any;
  public username = '';
  public password = '';
  public email = '';
  public phone = '';
  public gender = 'Male';
  public citizenIdentificationString = '';
  public citizenIdentificationUrlFront = '';
  public citizenIdentificationUrlBack = '';
  public confirmPassword = '';
  public dob = '';
  public address = '';
  public avatarUrl = '';
  public flag = false;
  public polices = false;
  filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  validMail: boolean = true;
  validPolice: boolean = true;
  matchPassword: boolean = true;
  fileFont!:File;
  fileBack!:File;


  public valid() {
    this.validPolice = this.polices;
    this.validMail = this.filter.test(this.email);
    if (this.username == '') {
      return;
    } else if (this.address == '') {
      return;
    } else if (this.dob == '') {
      return;
    } else if (this.citizenIdentificationString == '') {
      return;
    } else if (this.phone == '') {
      return;
    } else if (this.citizenIdentificationUrlFront == '') {
      return;
    } else if (this.citizenIdentificationUrlBack == '') {
      return;
    } else if (this.address == '') {
      return;
    } else if (this.password != this.confirmPassword) {
      this.matchPassword = false;
      return;
    } else if (this.validPolice == false) {
      return;
    } else if (this.validMail == false) {
      return;
    } else return true;
  }
  constructor(
    private http: ServerHttpService,
    private router: Router,
    private route: ActivatedRoute,
    private storage: AngularFireStorage
  ) {}
  ngOnInit(): void {}

  public register() {
    if (this.valid() == true) {

      // Image Font
      const pathFont = "landlord/citizenIdentification/" + this.citizenIdentificationUrlFront;
      const fileRefFont = this.storage.ref( pathFont );
      this.storage.upload( pathFont ,this.fileFont);

      // Image Back
      const pathBack = "landlord/citizenIdentification/" + this.citizenIdentificationUrlBack;
      const fileRefBack = this.storage.ref( pathFont );
      this.storage.upload( pathBack ,this.fileBack);


      this.http
        .registerLandlord(
          this.username,
          this.password,
          this.address,
          this.gender,
          this.email,
          this.phone,
          this.citizenIdentificationString,
          this.dob + '',
          this.avatarUrl,
          this.citizenIdentificationUrlFront,
          this.citizenIdentificationUrlBack
        )
        .subscribe(
          (data) => {
            localStorage.setItem('registerSuccess', 'true');
            this.router.navigate(['/Login'], { relativeTo: this.route });
          },
          (error) => {
            if (error['status'] == 500) {
              this.registerError = 'please check your phone number!';
            } else this.registerError = error['message'];
          }
        );
    }
  }

  onSelectImageFont(event: any) {
    if (event.target.files.length > 0) {
      console.log(event.target.files[0].name);
      this.citizenIdentificationUrlFront = event.target.files[0].name;
      console.log('image string', this.citizenIdentificationUrlFront);
      this.fileFont = event.target.files[0];
      console.log('file' , this.fileFont);
    }
  }

  onSelectImageBack(event: any) {
    if (event.target.files.length > 0) {
      console.log(event.target.files[0].name);
      this.citizenIdentificationUrlBack = event.target.files[0].name;
      console.log('image string', this.citizenIdentificationUrlBack);
      this.fileBack = event.target.files[0];
    }
  }
}
