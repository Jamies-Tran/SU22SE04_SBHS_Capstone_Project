import { Component, OnInit } from '@angular/core';
import { Editor, Toolbar } from 'ngx-editor';

@Component({
  selector: 'app-homestay-detail',
  templateUrl: './homestay-detail.component.html',
  styleUrls: ['./homestay-detail.component.scss']
})
export class HomestayDetailComponent implements OnInit {

  constructor() { }

  ngOnInit(): void {
    this.editor = new Editor();
  }

   // richtext
   editor!: Editor;
   html!: '';
   toolbar: Toolbar = [
     ['bold', 'italic'],
     ['underline', 'strike'],
     ['code', 'blockquote'],
     ['ordered_list', 'bullet_list'],
     [{ heading: ['h1', 'h2', 'h3', 'h4', 'h5', 'h6'] }],
     ['link', 'image'],
     ['text_color', 'background_color'],
     ['align_left', 'align_center', 'align_right', 'align_justify'],
   ];
}
