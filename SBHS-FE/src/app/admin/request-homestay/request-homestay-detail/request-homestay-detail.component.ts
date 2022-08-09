import { Component, OnInit } from '@angular/core';
import { ServerHttpService } from 'src/app/services/verify-homestay.service';
import { ImageService } from '../../../services/image.service';

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
  homestayImagesList : string[] = []
  homestayFacilityList: any
  homestayAftercareList: any
  public isAccept = true;
  public isReject = false;
  public rejectMessage = "";
  imageUrl:string =""
  constructor(private http: ServerHttpService,private image: ImageService) { }

  ngOnInit(): void {
    this.http.getRequestHomestayDetail().subscribe(async (data) =>{
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

      this.imageLicenseUrl = await this.image.getImage ( 'license/' + data["imageLicenseUrl"])

      for(let i of data["homestayImagesList"]){
        this.imageUrl = await this.image.getImage('homestay/' + i.url);
        console.log('image name:' , i.url);
        console.log('image url' , this.imageUrl);
        this.homestayImagesList.push(this.imageUrl);
      }
      // this.homestayImagesList = data["homestayImagesList"]

      this.homestayAftercareList = data["homestayAftercareList"]
      this.homestayFacilityList= data["homestayFacilityList"]
      console.log(data)
    })
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
