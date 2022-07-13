import { Component, OnInit } from '@angular/core';
import { ForgetPasswordService } from '../../services/forget-password.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-input-password',
  templateUrl: './input-password.component.html',
  styleUrls: ['./input-password.component.scss']
})
export class InputPasswordComponent implements OnInit {

  public password="";
  public comfirmPassword="";
  constructor(private http: ForgetPasswordService , private router: Router) { }

  ngOnInit(): void {
  }

  public inputPassword(){
    this.http.inputPassword(this.password).subscribe((data => {console.log(data)}));
  }


}
