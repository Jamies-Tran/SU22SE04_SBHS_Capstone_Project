import { Component, OnInit } from '@angular/core';
import { ServerHttpService } from 'src/app/services/verify-homestay.service';

@Component({
  selector: 'app-request-homestay',
  templateUrl: './request-homestay.component.html',
  styleUrls: ['./request-homestay.component.scss']
})
export class RequestHomestayComponent implements OnInit {
  values : data[] = [];
  public status ="All";
  registerError: string ="";
  constructor(private http: ServerHttpService) {
  }
  ngOnInit(): void {
   this.getStatusHomestay();
  }
  public getStatusHomestay(){
    this.http.getRequestHomestay(this.status).subscribe((data =>{
      this.values = data;
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
        localStorage.setItem("id",value+"")
    }
  public accept(){
    this.http.verifyHomestay(this.Id +"",this.isAccept,this.rejectMessage).subscribe((data =>{
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
    this.rejectMessage = "not enough condition"
    this.http.verifyHomestay(this.Id +"",this.isReject,this.rejectMessage).subscribe((data =>{
      if(data !=null){
        location.reload();
      }
    }),
    error =>{
      if(error["status"] == 500){
        this.registerError = "please check your information again!"
      }else this.registerError = error
    })
  }
  title ='pagination';
  page: number=1;
  count:number=0;
  tableSize: number = 15;
  tableSizes: any = [5,10,15,20];

  onTableDataChange(event: any){
    this.page = event;
    this.values;
  }
  onTableSizeChange(event: any): void{
    this.tableSize = event.target.value;
    this.page=1;
    this.values;
  }
}


export interface data {
  createdBy: string;
  id: number;
  createdDate: string;
  type: string;
  status: string;

}
