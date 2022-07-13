import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { InputUsernameService } from './../../services/input-username.service';


@Component({
  selector: 'app-input-username',
  templateUrl: './input-username.component.html',
  styleUrls: ['./input-username.component.scss']
})


export class InputUsernameComponent implements OnInit {

  public userName="";
  constructor(private http: InputUsernameService , private router: Router) { }

  ngOnInit(): void {
  }

  public inputUsername(){
    this.http.inputUserName(this.userName).subscribe((data => {console.log(data)}));
  }

}
