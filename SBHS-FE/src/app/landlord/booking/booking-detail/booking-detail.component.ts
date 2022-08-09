import { Component, OnInit } from '@angular/core';
import { ServerHttpService } from 'src/app/services/booking.service';

@Component({
  selector: 'app-booking-detail',
  templateUrl: './booking-detail.component.html',
  styleUrls: ['./booking-detail.component.scss']
})
export class BookingDetailComponent implements OnInit {
  registerError: string="";
  constructor(private http: ServerHttpService) { }
  passengerName: string =""
  passengerPhone: string =""
  passengerEmail: string =""
  homestayName: string =""
  homestayLocation: string =""
  homestayCity: string =""
  homestayOwner: string =""
  homestayServiceList : any
  checkIn: string =""
  checkOut: string =""
  totalPrice: string =""
  status: string =""
  deposit: string =""
  ngOnInit(): void {
    this.http.getBookingDetail().subscribe((data =>{
      this.homestayServiceList = data["homestayServiceList"]
      this.passengerName = data["passengerName"]
      this.passengerPhone = data["passengerPhone"]
      this.passengerEmail = data["passengerEmail"]
      this.homestayName = data["homestayName"]
      this.homestayLocation = data["homestayLocation"]
      this.homestayCity = data["homestayCity"]
      this.checkIn = data["checkIn"]
      this.checkOut = data["checkOut"]
      this.totalPrice = data["totalPrice"]
      this.deposit = data["deposit"]
    }))
  }
  public isAccept = true;
  public isReject = false;
  public rejectMessage = "";
  public accept(){
    this.http.confirmHomestay(localStorage.getItem("id") +"",this.isAccept,this.rejectMessage).subscribe((data =>{
      if(data !=null){
        location.reload();
      }
      console.log(data)
    }),
    error =>{
      if(error["status"] == 500){
        this.registerError = "please check your information again!"
      }else this.registerError = error
    })
  }
  public reject(){
    this.rejectMessage = "Homestay is maintained"
    this.http.confirmHomestay(localStorage.getItem("id") +"",this.isReject,this.rejectMessage).subscribe((data =>{
      if(data !=null){
        location.reload();
      }
    }),
    error =>{
      if(error["status"] == 500){
        this.registerError = "please check your information again!"
      }else this.registerError = error
    })
  }

}
