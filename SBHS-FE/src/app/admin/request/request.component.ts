import { OnInit, Component, ViewChild} from '@angular/core';
import {MatPaginator} from '@angular/material/paginator';
import {MatSort} from '@angular/material/sort';
import {MatTableDataSource} from '@angular/material/table';
import { ServerHttpService } from 'src/app/services/verify-landlord.service';

@Component({
  selector: 'app-request',
  templateUrl: './request.component.html',
  styleUrls: ['./request.component.scss']
})
export class RequestComponent  implements OnInit{
  values : data[] = [];
  
  // displayedColumns: string[] = ['id', 'createdBy', 'createdDate', 'type', 'status', 'actions'];
  // dataSource= new MatTableDataSource(this.values);


  // @ViewChild(MatPaginator) paginator!: MatPaginator;
  // @ViewChild(MatSort) sort!: MatSort;

  constructor(private http: ServerHttpService) {
  }

  // ngAfterViewInit() {
  //   this.dataSource.paginator = this.paginator;
  //   this.dataSource.sort = this.sort;
  // }

  // applyFilter(event: Event) {
  //   const filterValue = (event.target as HTMLInputElement).value;
  //   this.dataSource.filter = filterValue.trim().toLowerCase();

  //   if (this.dataSource.paginator) {
  //     this.dataSource.paginator.firstPage();
  //   }
  // }
  
  ngOnInit(): void {
    this.http.getLanlord().subscribe((data =>{
      this.values = data;
      console.log(this.values)
      console.log(data[0]["createdBy"])
    }),
    error =>{
      alert(error)
    })
  }
  public Id = 0;
  public isAccept = true;
  public isReject = false;
  public rejectMessage = "";
  public onItemSelector(value :number) {
        this.Id=value;
    }
  public accept(){
    this.http.verifyLandlord(this.Id +"",this.isAccept,this.rejectMessage).subscribe((data =>{
      if(data !=null){
        location.reload();
      }
      
      console.log(data)
    }),
    error =>{
      alert(error)
    })
  }
  public reject(){
    this.http.verifyLandlord(this.Id +"",this.isReject,this.rejectMessage).subscribe((data =>{
      if(data !=null){
        location.reload();
      }
    }),
    error =>{
      alert(error)
    })
  }

}


export interface data {
  createdBy: string;
  id: number;
  createdDate: string;
  type: string;
  status: string;

}


