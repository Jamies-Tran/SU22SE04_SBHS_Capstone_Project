import { Component, OnInit } from '@angular/core';
import { ForgetPasswordService } from '../../services/forget-password.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-input-otp',
  templateUrl: './input-otp.component.html',
  styleUrls: ['./input-otp.component.scss']
})
export class InputOtpComponent implements OnInit {

  public otp="";
  constructor(private http: ForgetPasswordService , private router: Router) { }

  ngOnInit(): void {
  }

  public inputOTP(){
    this.http.inputOTP(this.otp).subscribe((data => {console.log(data)}));
  }


}
