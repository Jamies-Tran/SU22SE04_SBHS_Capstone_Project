import { Component, OnInit } from '@angular/core';
import { ServerHttpService } from 'src/app/services/profile.service';
import { ImageService } from '../../services/image.service';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss'],
})
export class ProfileComponent implements OnInit {
  constructor(private http: ServerHttpService, private image: ImageService) {}
  public username = '';
  public email = '';
  public phone = '';
  public gender = '';
  public citizenIdentificationString = '';
  public dob = '';
  public address = '';
  public avatarUrl = '';
  public balance = '';
  showDiv = {
    // profile: true,
    addBalance: false,
    changePass: false,
    cashOut:false,
    editProfile:false
  };
  toggle = {
    addBalance: false,
    changePass: false,
    cashOut:false,
    editProfile:false
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

      this.avatarUrl = await this.image.getImage(
        'homestay/' + data['avatarUrl']
      );
      //
      let encoded: string = btoa('{"username":"landlord003"}');
      console.log(encoded);
      let decoded: string = atob('eyJ1c2VybmFtZSI6ImxhbmRsb3JkMDAzIn0=');
      console.log(decoded);
    });
    //get balance
    this.http.getBalance().subscribe((balance) => {
      this.balance = balance['balance'];
      console.log(balance);
    });
  }
}
