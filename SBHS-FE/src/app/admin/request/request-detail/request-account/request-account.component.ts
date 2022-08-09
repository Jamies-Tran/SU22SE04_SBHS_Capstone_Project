import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { FirebaseError, initializeApp } from 'firebase/app';
import { FirebaseApp } from 'firebase/app';
import { ServerHttpService } from 'src/app/services/verify-landlord.service';
import { ImageService } from '../../../../services/image.service';

@Component({
  selector: 'app-request-account',
  templateUrl: './request-account.component.html',
  styleUrls: ['./request-account.component.scss'],
})
export class RequestAccountComponent implements OnInit {
  registerError: string = "";
  constructor(private http: ServerHttpService,private image: ImageService,  private router: Router,private route: ActivatedRoute) {}
  public username = '';
  public email = '';
  public phone = '';
  public gender = '';
  public citizenIdentificationString = '';
  public dob = '';
  public address = '';
  public avatarUrl = '';
  public citizenIdentificationUrlFont= "";
  public citizenIdentificationUrlBack ="";
  ngOnInit(): void {
    this.http.getLandlordDetail().subscribe(async (data) =>{
      this.username = data['username'];
      this.dob = data['dob'];
      this.email = data['email'];
      this.citizenIdentificationString = data['citizenIdentificationString'];
      this.gender = data['gender'];
      this.phone = data['phone'];
      this.address = data['address'];
      console.log('avatar' ,data['avataUrl'] );
      if(data['avataUrl'] ){
        this.avatarUrl = await this.image.getImage('landlord/avatar/' + data['avataUrl']);
      }else{
        this.avatarUrl = await this.image.getImage('landlord/avatar/default.png');
      }

      this.citizenIdentificationUrlFont = await this.image.getImage('landlord/citizenIdentification/' + data['citizenIdentificationUrlFront']);
      this.citizenIdentificationUrlBack = await this.image.getImage('landlord/citizenIdentification/' + data['citizenIdentificationUrlBack']);

      console.log(this.citizenIdentificationUrlBack);
      console.log(this.citizenIdentificationUrlFont);
      console.log(this.avatarUrl);
      console.log(data['citizenIdentificationUrlFront']);
      console.log(data['citizenIdentificationUrlBack']);
    })
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
      if(error["status"] == 500){
        this.registerError = "please check your information again!"
      }else this.registerError = error["message"]
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


