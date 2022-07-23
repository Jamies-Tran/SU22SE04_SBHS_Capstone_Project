import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ForgetPasswordService } from '../services/forget-password.service';

@Component({
  selector: 'app-forget-password',
  templateUrl: './forget-password.component.html',
  styleUrls: ['./forget-password.component.scss']
})
export class ForgetPasswordComponent implements OnInit {
  public username = "";
  public otp = "";
  public newPassword = "";
  constructor(private http: ForgetPasswordService , private router: Router,private route: ActivatedRoute) { }

  ngOnInit(): void {
  }
  public getOtp() {
    console.log(this.username)
    this.http.inputUserName(this.username).subscribe((data => {

    }))
  }
  public inputOtp() {
    console.log(this.username)
    this.http.inputOTP(this.username,this.otp).subscribe((data => {
      
    }))
  }
  public inputPassword() {
    console.log(this.username)
    this.http.inputPassword(this.username, this.newPassword).subscribe((data => {
      
    }))
  }
}
