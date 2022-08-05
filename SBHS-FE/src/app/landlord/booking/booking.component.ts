import { Component, OnInit } from '@angular/core';
import {MatPaginator} from '@angular/material/paginator';
import {MatSort} from '@angular/material/sort';
import {MatTableDataSource} from '@angular/material/table';

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

  public status ="All";

  constructor() { }

  ngOnInit(): void {
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
  name: string;
  mobile: string;
  email: string;
  arrive: string;
  depart: string;
  homestay:string;

}
