import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Route, Router } from '@angular/router';
import { ServerHttpService } from '../services/register.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent implements OnInit {
  registerError : any;
  public username = "";
  public password = "";
  public email = "";
  public phone = "";
  public gender = "Male";
  public citizenIdentificationString = "";
  public citizenIdentificationUrlFront = "";
  public citizenIdentificationUrlBack = "";
  public confirmPassword = "";
  public dob =  "";
  public address = "";
  public avatarUrl = "";
  public flag = false;
  public polices = false;
  filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  validMail : boolean = true;
  validPolice : boolean = true;
  matchPassword : boolean = true;
  public valid(){
    this.validPolice = this.polices
    this.validMail = this.filter.test(this.email)
    if(this.username == ""){
      return
    }else if(this.address == ""){
      return
    }else if(this.dob == ""){
      return
    }else if(this.citizenIdentificationString == ""){
      return
    }else if(this.phone == ""){
      return
    }else if(this.citizenIdentificationUrlFront == ""){
      return
    }else if(this.citizenIdentificationUrlBack == ""){
      return
    }else if(this.address == ""){
      return
    }else if(this.password != this.confirmPassword){
      this.matchPassword = false
      return
    }else if(this.validPolice == false){
      return
    }else if(this.validMail == false){
      return
    }else return true;
  }
  constructor(private http: ServerHttpService, private router: Router,private route: ActivatedRoute) { }
  ngOnInit(): void {
  }

  public register() {
    if(this.valid() == true){
      this.http.registerLandlord(this.username,this.password,this.address,this.gender,this.email,this.phone,
        this.citizenIdentificationString,this.dob +"",this.avatarUrl,this.citizenIdentificationUrlFront, this.citizenIdentificationUrlBack).subscribe((data => {
      localStorage.setItem("registerSuccess","true");
      this.router.navigate(['/Login'], {relativeTo: this.route});
    }),
    error =>{
      if(error["status"] == 500){
        this.registerError = "please check your phone number!"
      }else this.registerError = error["message"]
    })}
  }
}

