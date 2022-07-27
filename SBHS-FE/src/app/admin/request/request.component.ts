import { AfterViewInit, Component, ViewChild} from '@angular/core';
import {MatPaginator} from '@angular/material/paginator';
import {MatSort} from '@angular/material/sort';
import {MatTableDataSource} from '@angular/material/table';
import { ServerHttpService } from 'src/app/services/verify-landlord.service';

@Component({
  selector: 'app-request',
  templateUrl: './request.component.html',
  styleUrls: ['./request.component.scss']
})
export class RequestComponent  implements AfterViewInit{

  displayedColumns: string[] = ['id', 'name', 'date', 'type', 'status', 'actions'];
  dataSource= new MatTableDataSource(ELEMENT_DATA);


  @ViewChild(MatPaginator) paginator!: MatPaginator;
  @ViewChild(MatSort) sort!: MatSort;

  constructor(private http: ServerHttpService) {

``


  }

  ngAfterViewInit() {
    this.dataSource.paginator = this.paginator;
    this.dataSource.sort = this.sort;
  }

  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = filterValue.trim().toLowerCase();

    if (this.dataSource.paginator) {
      this.dataSource.paginator.firstPage();
    }
  }
  public values = "";
  ngOnInit(): void {
    this.http.getLanlord().subscribe((data =>{
      this.values = data;
      console.log(this.values)
    }),
    error =>{
      alert(error)
    })
  }

}


export interface data {
  name: string;
  id: number;
  date: number;
  type: string;
  status: string;

}

const ELEMENT_DATA: data[] = [
  {id: 1, name: 'Hydrogen', date: 1/1/1, type: 'H' , status:''},
  {id: 2, name: 'Hydrogen', date: 1/1/1, type: 'H' , status:''},
  {id: 3, name: 'Hydrogen', date: 1/1/1, type: 'H' , status:''},
  {id: 4, name: 'Hydrogen', date: 1/1/1, type: 'H' , status:''},
  {id: 5, name: 'Hydrogen', date: 1/1/1, type: 'H' , status:''},

];


