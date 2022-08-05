import { Component, OnInit } from '@angular/core';
import { ServerHttpService } from 'src/app/services/verify-homestay.service';

@Component({
  selector: 'app-request-homestay-detail',
  templateUrl: './request-homestay-detail.component.html',
  styleUrls: ['./request-homestay-detail.component.scss']
})
export class RequestHomestayDetailComponent implements OnInit {
  createdBy :string =""
  createdByEmail :string =""
  createdDate :string =""
  type :string =""
  status :string =""
  homestayName :string =""
  numberOfRoom :string =""
  price :string =""
  city :string =""
  checkInTime :string =""
  CheckOutTime :string =""
  address :string =""
  description :string =""
  imageLicenseUrl :string =""
  homestayImagesList : any
  homestayFacilityList: any
  homestayAftercareList: any
  public isAccept = true;
  public isReject = false;
  public rejectMessage = "";
  constructor(private http: ServerHttpService) { }

  ngOnInit(): void {
    this.http.getRequestHomestayDetail().subscribe((data =>{
      this.createdBy = data["createdBy"]
      this.homestayName = data["homestayName"]
      this.createdByEmail = data["createdByEmail"]
      this.numberOfRoom = data["numberOfRoom"]
      this.price = data["price"]
      this.city = data["city"]
      this.checkInTime = data["checkInTime"]
      this.CheckOutTime = data["checkOutTime"]
      this.address = data["address"]
      this.description = data["description"]
      this.imageLicenseUrl = data["imageLicense"]
      this.homestayImagesList = data["homestayImagesList"]
      this.homestayAftercareList = data["homestayAftercareList"]
      this.homestayFacilityList= data["homestayFacilityList"]
      console.log(data)
    }))
  }


  public accept(){
    this.http.verifyHomestay(localStorage.getItem("id") +"",this.isAccept,this.rejectMessage).subscribe((data =>{
      if(data !=null){
        location.reload();
      }
      
      console.log(data)
    }),
    error =>{
      alert(error)
    })
  }
  public reject(){
    this.rejectMessage = "not enough condition"
    this.http.verifyHomestay(localStorage.getItem("id") +"",this.isReject,this.rejectMessage).subscribe((data =>{
      if(data !=null){
        location.reload();
      }
    }),
    error =>{
      alert(error)
    })
  }
}
