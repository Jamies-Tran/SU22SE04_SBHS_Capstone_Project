import { Component, OnInit } from '@angular/core';
import { ServerHttpService } from 'src/app/services/verify-homestay.service';

@Component({
  selector: 'app-request-homestay',
  templateUrl: './request-homestay.component.html',
  styleUrls: ['./request-homestay.component.scss']
})
export class RequestHomestayComponent implements OnInit {
  values : data[] = [];
  
  // displayedColumns: string[] = ['id', 'createdBy', 'createdDate', 'type', 'status', 'actions'];
  // dataSource= new MatTableDataSource(this.values);


  // @ViewChild(MatPaginator) paginator!: MatPaginator;
  // @ViewChild(MatSort) sort!: MatSort;

  constructor(private http: ServerHttpService) {
  } 
  ngOnInit(): void {
    this.http.getLanlord().subscribe((data =>{
      this.values = data;
      console.log(this.values)
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
