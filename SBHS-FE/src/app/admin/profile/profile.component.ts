import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ServerHttpService } from 'src/app/services/profile.service';
import { ImageService } from '../../services/image.service';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss']
})
export class ProfileComponent implements OnInit {


  constructor(
    private http: ServerHttpService,
    private image: ImageService,
    private router: Router,
    private route: ActivatedRoute
  ) {}
  public username = '';
  public email = '';
  public phone = '';
  public gender = '';
  public citizenIdentificationString = '';
  public dob = '';
  public address = '';
  public avatarUrl = '';
  public balance = '';
  newPassword !: string;

  // set min-max date
  minDate!: Date;
  maxDate!: Date;

  showDiv = {
    // profile: true,
    addBalance: false,
    changePass: false,
    cashOut: false,
    editProfile: true,
  };
  toggle = {
    addBalance: false,
    changePass: false,
    cashOut: false,
    editProfile: false,
  };

  ngOnInit(): void {
    //get profile
    this.http.getProfile().subscribe(async (data) => {
      console.log(localStorage.getItem('userToken'));
      console.log(data);
      this.username = data['username'];
      this.dob = data['dob'];
      this.email = data['email'];
      this.citizenIdentificationString = data['citizenIdentificationString'];
      this.gender = data['gender'];
      this.phone = data['phone'];
      this.address = data['address'];
      if (data['avatarUrl']) {
        this.avatarUrl = await this.image.getImage(
          'avatar/' + data['avatarUrl']
        );
      } else {
        this.avatarUrl = await this.image.getImage(
          'landlord/avatar/default.png'
        );
      }

      //
    });
    //get balance
    this.http.getBalance().subscribe((balance) => {
      this.balance = balance['balance'];
    });
  }
  public amount = '';
  public addMoney() {
    this.http.addMoney(this.amount).subscribe(
      (data) => {
        console.log(data);
        location.href = data['payUrl'];
      },
      (error) => {
        alert(error);
      }
    );
  }
}
