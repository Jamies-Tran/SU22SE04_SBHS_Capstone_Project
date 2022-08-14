import { Component, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';

@Component({
  selector: 'app-page1',
  templateUrl: './page1.component.html',
  styleUrls: ['./page1.component.scss']
})
export class Page1Component implements OnInit {

  constructor(private _formBuilder: FormBuilder) { }

  name = 'Dynamic Add Fields';
  values : any[]=[] ;
  ngOnInit() {
    console.log('value', this.values);
  }

  removevalue(i:any){
    this.values.splice(i,1);
  }

  addvalue(){
    this.values.push({name:"", amount:"", status:false });
    console.log('values', this.values);
    console.log('size', this.values.length);
  }


}
