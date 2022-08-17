import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-special-day',
  templateUrl: './special-day.component.html',
  styleUrls: ['./special-day.component.scss']
})
export class SpecialDayComponent implements OnInit {

  newSpecialDay: any[] = [];
  constructor() { }

  ngOnInit(): void {
  }
  addSpecialDay(){}
  removeSpecialDay(i :any){}
  resetSpecial(){}
}
