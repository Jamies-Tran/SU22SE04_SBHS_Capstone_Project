import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ForgetPasswordService } from '../../services/forget-password.service';


@Component({
  selector: 'app-input-username',
  templateUrl: './input-username.component.html',
  styleUrls: ['./input-username.component.scss']
})


export class InputUsernameComponent implements OnInit {

  public userName = "";
  constructor(private http: ForgetPasswordService, private router: Router,private route: ActivatedRoute) { }

  ngOnInit(): void {
  }

  public inputUsername() {
    console.log(this.userName)

    this.http.inputUserName(this.userName).subscribe((data => {

      this.router.navigate(['/ForgetPassword/Step2'], {relativeTo: this.route});
      console.log(this.userName)
      console.log(data)
    }));

  }

}
