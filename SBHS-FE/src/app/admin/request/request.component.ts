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
  public status ="All";
  registerError: string = "";
  constructor(private http: ServerHttpService) {
  }
  ngOnInit(): void {
    this.getStatusLandlord();
  }
  public getStatusLandlord(){
    this.http.getLanlord(this.status).subscribe((data =>{
      this.values = data;
    }),
    error =>{
      alert(error)
    })
  }
  public Id = 0;
  public createBy =""
  public isAccept = true;
  public isReject = false;
  public rejectMessage = "";
  public onItemSelector(id: number, createdBy: string) {
        this.Id=id;
        localStorage.setItem("id", id+"")
        localStorage.setItem("createdBy", createdBy);
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
      if(error["status"] == 500){
        this.registerError = "please check your information again!"
      }else this.registerError = error["message"]
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


