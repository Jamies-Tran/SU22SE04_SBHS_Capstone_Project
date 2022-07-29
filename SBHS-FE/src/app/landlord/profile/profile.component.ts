import { Component, OnInit } from '@angular/core';
import { ServerHttpService } from 'src/app/services/profile.service';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss']
})
export class ProfileComponent implements OnInit {

  constructor(private http: ServerHttpService) { }
  public username = "";
  public email = "";
  public phone = "";
  public gender = "";
  public citizenIdentificationString = "";
  public dob =  "";
  public address = "";
  public avatarUrl = "";
  public balance ="";
  ngOnInit(): void {
    //get profile
    this.http.getProfile().subscribe((data =>{
      console.log(localStorage.getItem("userToken"))
      console.log(data)
      this.username = data["username"];
      this.dob = data["dob"];
      this.email = data["email"];
      this.citizenIdentificationString = data["citizenIdentificationString"];
      this.gender = data["gender"];
      this.phone = data["phone"];
      this.address = data["address"];
      this.avatarUrl = data["avatarUrl"]
    }));
    //get balance
    this.http.getBalance().subscribe((balance =>{
      this.balance = balance["balance"]
      console.log(balance)
    }))
  }

}
