import { Component, OnInit } from '@angular/core';
import {MatDialog} from '@angular/material/dialog';
import { ServerHttpService } from 'src/app/services/homestay.service';
import { DeleteHomestayDialogComponent } from '../../pop-up/delete-homestay-dialog/delete-homestay-dialog.component';



@Component({
  selector: 'app-homestay',
  templateUrl: './homestay.component.html',
  styleUrls: ['./homestay.component.scss']
})
export class HomestayComponent implements OnInit {

  constructor(public dialog: MatDialog, private http: ServerHttpService) { }
  value : any;
  ngOnInit(): void {
    this.http.getHomestayList().subscribe((data =>{
      this.value = data;
      console.log(data)
    }))
  }

  openDialog() {
    this.dialog.open(DeleteHomestayDialogComponent);
  }
}


