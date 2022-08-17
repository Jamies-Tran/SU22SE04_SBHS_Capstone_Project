import { Component, OnInit } from '@angular/core';
import { ServerHttpService } from 'src/app/services/specialday.service';

@Component({
  selector: 'app-special-day',
  templateUrl: './special-day.component.html',
  styleUrls: ['./special-day.component.scss']
})
export class SpecialDayComponent implements OnInit {

  newSpecialDay: any[] = [];
  Error: string ="";
  constructor(private http: ServerHttpService) { };
  // valueday30: Array<number> =[];
  // valueday31 : Array<number> =[];
  // valueday28 : Array<number> =[];
  // valueMonth : Array<number> =[];
  startDay = "";
  endDay ="";
  startMonth ="";
  endMonth ="";
  description ="";
  flag = false;
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
    this.newSpecialDay.push(this.startDay,this.startMonth,this.endDay,this.endMonth,this.description)
    this.http.addSpecialDay(this.startDay,this.startMonth,this.endDay,this.endMonth,this.description).subscribe((data =>{
      this.flag =true
    }),
    (error) => {
      if (error['status'] == 500) {
        this.Error = 'please check your information again!';
      } else this.Error = error;
    })
  }
}
