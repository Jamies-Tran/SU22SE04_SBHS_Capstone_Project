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
  public flag = false;
  public polices = false;
  constructor(private http: ServerHttpService, private router: Router,private route: ActivatedRoute) { }
  ngOnInit(): void {
  }
  public checkEmail() {
    var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    if(this.username ===""){
      alert('Please enter username!!!')
      return
    }
    else if (!filter.test(this.email)) {
        alert('wrong mail.\nExample@gmail.com');
        return
    }else if(this.address === ""){
      alert('Please enter Address!!!')
      return
    }else if(this.citizenIdentificationString === ""){
      alert('Please enter ID National!!!')
      return
    }else if(this.password === ""){
      alert('Please enter Password!!!')
      return
    }else if(this.password != this.confirmPassword){
      alert('Wrong confirm password!!!')
      return
    }else if(this.phone === ""){
      alert('Please enter phone number!!!')
      return
    }else if(this.polices === false){
      alert('Please read polices and tick a box!!!')
      return
    }
    else this.flag = true

}
  public register() {
    if(this.flag === true){
      this.http.registerLandlord(this.username,this.password,this.address,this.gender,this.email,this.phone,this.citizenIdentificationString,this.dob +"",this.avatarUrl,this.citizenIdentificationUrl).subscribe((data => {
      alert("register successful!!!");
      this.router.navigate(['/Login'], {relativeTo: this.route});
    }),
    error =>{
      alert(error)
    })}
  }
}
