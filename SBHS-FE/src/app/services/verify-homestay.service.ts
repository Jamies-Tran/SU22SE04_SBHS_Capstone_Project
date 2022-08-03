import { HttpClient, HttpErrorResponse, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { throwError } from 'rxjs/internal/observable/throwError';
import { catchError } from 'rxjs/internal/operators/catchError';

@Injectable({
  providedIn: 'root'
})

export class ServerHttpService {
  private httpOptions = {
    headers: new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization' :  'Bearer '+ localStorage.getItem('userToken')
    })
  };
  public model: any = {};
  private REST_API_SERVER = 'http://localhost:8080';
  constructor(private httpClient: HttpClient) { }
  public getLanlord() {
    const url = `${this.REST_API_SERVER}/api/request/homestay/all`;
    return this.httpClient
      .get<any>(url, this.httpOptions)
      .pipe(catchError(this.handleError));
  }
  public verifyLandlord(requestId : string, isAccepted:boolean,rejectMessage:string){
    var value = {
      isAccepted,rejectMessage
    }
    const url =`${this.REST_API_SERVER}/api/request/verification/homestay/`+requestId+``;
    return this.httpClient
    .patch<any>(url,value,this.httpOptions)
    .pipe(catchError(this.handleError));
  }
  private handleError(error: HttpErrorResponse) {
    return throwError(
      error.error["message"]);
  };

}
