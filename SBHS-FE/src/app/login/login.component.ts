import { Token } from '@angular/compiler';
import { Component, OnInit } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { ServerHttpService } from '../services/login.service';
// import {JwtHelperService} from '@auth0/angular-jwt';
@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {
  
  public userName= "";
  public password = "";
  constructor(private http: ServerHttpService , private router: Router) {
   }
  ngOnInit(): void {
    
  }
  public getProfile(){
    this.http.login(this.userName, this.password).subscribe((data =>{
      console.log(data)
    }))
  }
}
