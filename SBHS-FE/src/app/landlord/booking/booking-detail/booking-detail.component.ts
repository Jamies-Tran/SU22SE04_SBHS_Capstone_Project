import { Component, OnInit } from '@angular/core';
import { ServerHttpService } from 'src/app/services/booking.service';

@Component({
  selector: 'app-booking-detail',
  templateUrl: './booking-detail.component.html',
  styleUrls: ['./booking-detail.component.scss']
})
export class BookingDetailComponent implements OnInit {
  values:any
  homestayServiceList:any
  constructor(private http: ServerHttpService) { }

  ngOnInit(): void {
    this.http.getBookingDetail().subscribe((data =>{
      this.values = data
      this.homestayServiceList = data["homestayServiceList"]
    }))
  }

}
