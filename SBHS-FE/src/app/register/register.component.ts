import { Component, OnInit } from '@angular/core';
import { ServerHttpService } from '../services/register.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent implements OnInit {
  public username = "";
  public password = "";
  public email = "";
  public phone = "";
  public gender = "Male";
  public citizenIdentification = "";
  public citizenIdentificationUrl = "";
  public confirmPassword = "";
  public dobTemp = "";
  public dob = this.dobTemp + "";
  constructor(private http: ServerHttpService) { }
  ngOnInit(): void {
  }
  public register() {
    console.log(this.dob)
    this.http.registerLandlord(this.username, this.password, this.email, this.phone, this.dob + "",  this.citizenIdentificationUrl,this.citizenIdentification,).subscribe((data => {
      alert("register successful!!!");

    }))
  }
}
