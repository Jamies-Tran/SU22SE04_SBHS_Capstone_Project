import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Route, Router } from '@angular/router';
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
  public citizenIdentificationString = "";
  public citizenIdentificationUrl = "";
  public confirmPassword = "";
  public dob =  "";
  public address = "";
  public avatarUrl = "male";
  constructor(private http: ServerHttpService, private router: Router,private route: ActivatedRoute) { }
  ngOnInit(): void {
  }
  public checkEmail() {
    var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    if (!filter.test(this.email)) {
        alert('Hay nhap dia chi email hop le.\nExample@gmail.com');
    }
}
  public register() {
    console.log(this.dob)
    console.log(this.citizenIdentificationString)
    this.http.registerLandlord(this.username,this.password,this.address,this.gender,this.email,this.phone,this.citizenIdentificationString,this.dob +"",this.avatarUrl,this.citizenIdentificationUrl).subscribe((data => {
      alert("register successful!!!");
      this.router.navigate(['/Login'], {relativeTo: this.route});
    }),
    error =>{
      alert(error)
    })
  }
}
