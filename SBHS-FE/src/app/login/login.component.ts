import { Token } from '@angular/compiler';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
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
  constructor(private http: ServerHttpService , private router: Router,private route: ActivatedRoute) {
   }
  ngOnInit(): void {
    
  }
  public getProfile(){
    this.http.login(this.userName, this.password).subscribe((data =>{
      
      localStorage.setItem('token',data);
      this.router.navigate(['/Landlord'], {relativeTo: this.route});
      console.log(localStorage.getItem('token'));
      console.log(data)
    }))
  }
}
