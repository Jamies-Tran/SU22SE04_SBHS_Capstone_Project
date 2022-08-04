import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { FirebaseError, initializeApp } from 'firebase/app';
import { FirebaseApp } from 'firebase/app';
import { ServerHttpService } from 'src/app/services/verify-landlord.service';

@Component({
  selector: 'app-request-account',
  templateUrl: './request-account.component.html',
  styleUrls: ['./request-account.component.scss'],
})
export class RequestAccountComponent implements OnInit {
  registerError: string = "";
  constructor(private http: ServerHttpService,  private router: Router,private route: ActivatedRoute) {}
  public username = '';
  public email = '';
  public phone = '';
  public gender = '';
  public citizenIdentificationString = '';
  public dob = '';
  public address = '';
  public avatarUrl = '';
  ngOnInit(): void {
    this.http.getLandlordDetail().subscribe((data =>{
      this.username = data['username'];
      this.dob = data['dob'];
      this.email = data['email'];
      this.citizenIdentificationString = data['citizenIdentificationString'];
      this.gender = data['gender'];
      this.phone = data['phone'];
      this.address = data['address'];
      this.avatarUrl = data['avataUrl']
    }))
  }
  public isAccept = true;
  public isReject = false;
  public rejectMessage = "";
  public accept(){
    this.http.verifyLandlord( localStorage.getItem("id") +"",this.isAccept,this.rejectMessage).subscribe((data =>{
      if(data !=null){
        this.router.navigate(['/Admin/Request'], {relativeTo: this.route});
      }
      
      console.log(data)
    }),
    error =>{
      alert(error)
    })
  }
  public reject(){
    this.http.verifyLandlord(localStorage.getItem("id")+"",this.isReject,this.rejectMessage).subscribe((data =>{
      if(data !=null){
        this.router.navigate(['/Admin/Request'], {relativeTo: this.route});
      }
    }),
    error =>{
      if(error["status"] == 500){
        this.registerError = "please check your information again!"
      }else this.registerError = error["message"]
    })
}
}
const firebaseConfig = {
  apiKey: 'AIzaSyAhXRZmd_yo9BuPi3MZzX2svj7E5M72vaI',
  authDomain: 'stay-with-me-356017.firebaseapp.com',
  projectId: 'stay-with-me-356017',
  storageBucket: 'stay-with-me-356017.appspot.com',
  messagingSenderId: '593303082715',
  appId: '1:593303082715:web:4e610a7104a49b8cfa1efe',
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);


