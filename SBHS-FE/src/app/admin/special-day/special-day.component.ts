import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-special-day',
  templateUrl: './special-day.component.html',
  styleUrls: ['./special-day.component.scss']
})
export class SpecialDayComponent implements OnInit {

  newSpecialDay: any[] = [];
  constructor() { };
  // valueday30: Array<number> =[];
  // valueday31 : Array<number> =[];
  // valueday28 : Array<number> =[];
  // valueMonth : Array<number> =[];
  startDay = "";
  endDay ="";
  startMonth ="";
  endMonth ="";
  ngOnInit(): void {
    // for (let index = 1; index < 31; index++) {
    //   this.valueday30.push(index)
    // }
    // for (let index = 1; index < 32; index++) {
    //   this.valueday31.push(index)
    // }
    // for (let index = 1; index < 29; index++) {
    //   this.valueday28.push(index)
    // }
    // for (let index = 1; index < 13; index++) {
    //   this.valueMonth.push(index)
    // }
    
  }
  addSpecialDay(){}
  removeSpecialDay(i :any){}
  resetSpecial(){}
  public add(){
    
  }
}
