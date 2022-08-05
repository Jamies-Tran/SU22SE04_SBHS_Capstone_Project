import { Component, OnInit } from '@angular/core';
import {MatPaginator} from '@angular/material/paginator';
import {MatSort} from '@angular/material/sort';
import {MatTableDataSource} from '@angular/material/table';
import { ServerHttpService } from 'src/app/services/booking.service';

@Component({
  selector: 'app-booking',
  templateUrl: './booking.component.html',
  styleUrls: ['./booking.component.scss']
})
export class BookingComponent implements OnInit {

  title='pagination';
  POST:any;
  page: number = 1;
  count: number=0;
  tableSize: number =5;
  tableSizes: any= [5,10,15,20];
  values : data[] = [];

  public name ="All";
  valueName:any;
  constructor(private http: ServerHttpService) { }

  ngOnInit(): void {
    this.http.getHomestayName().subscribe((data =>{
      this.valueName = data;
    }),
    error => {
      alert(error)
    })
  }
  
  onTableDataChange(event: any){
    this.page = event;
    this.values;
  }
  onTableSizeChange(event: any): void{
    this.tableSize = event.target.value;
    this.page=1;
    this.values;
  }
}
export interface data{
  passengerName:string,
  homestayName:string,
  homestayServiceList:Array<object>,
  checkIn:string,
  checkOut:string,
  totalPrice:string,
  status:string,
  deposite:string,
  id:string
}
