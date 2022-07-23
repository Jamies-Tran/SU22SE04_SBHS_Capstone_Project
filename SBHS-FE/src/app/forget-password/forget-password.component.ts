import { Component, OnInit } from '@angular/core';
import { ForgetPasswordService } from '../services/forget-password.service';
import { Router, ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-forget-password',
  templateUrl: './forget-password.component.html',
  styleUrls: ['./forget-password.component.scss']
})
export class ForgetPasswordComponent implements OnInit {
  public otp="";
  public password="";
  public comfirmPassword="";
  public userName = "";
  constructor(private http: ForgetPasswordService , private router: Router,private aRoute: ActivatedRoute) { }

  ngOnInit(): void {
  }

  public inputOTP(){
    this.http.inputOTP(this.otp).subscribe((data => {console.log(data)}));
  }

  public inputPassword(){
    this.http.inputPassword(this.password).subscribe((data => {console.log(data)}));
  }

  public inputUsername() {
    console.log(this.userName)

    this.http.inputUserName(this.userName).subscribe((data => {

      this.router.navigate(['/ForgetPassword/Step2'], {relativeTo: this.aRoute});
      console.log(this.userName)
      console.log(data)
    }));

  }

}
