import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-register-homestay',
  templateUrl: './register-homestay.component.html',
  styleUrls: ['./register-homestay.component.scss']
})
export class RegisterHomestayComponent implements OnInit {

  constructor() { }

  ngOnInit(): void {
  }

  files: File[] = [];

onSelect(event: { addedFiles: any; }) {
  console.log(event);
  this.files.push(...event.addedFiles);
}

onRemove(event: File) {
  console.log(event);
  this.files.splice(this.files.indexOf(event), 1);
}
}
