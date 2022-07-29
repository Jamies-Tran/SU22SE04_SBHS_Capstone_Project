import { HttpClient, HttpErrorResponse, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, throwError } from 'rxjs';

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
  public registerLandlord(name:string, address:string,city:string, price:any, payment:string,homestayServices: Array<any>,homestayFacilities:Array<any>) {
    var homestayLicense  ={
        "url":"1234.png"
        }


    var homestayImages =[
      {"url":"123.png"},
      {"url":"456.png"}
    ]
    var value = {
      name,address,city,price,payment,homestayLicense,homestayImages,homestayServices,homestayFacilities
    }
    console.log(value)
    const url = `${this.REST_API_SERVER}/api/homestay/register`;
    return this.httpClient
      .post<any>(url, value, this.httpOptions)
      .pipe(catchError(this.handleError));
  }
  private handleError(error: HttpErrorResponse) {
    // if (error.error instanceof ErrorEvent) {
    //   // A client-side or network error occurred. Handle it accordingly.
    //   console.error('An error occurred:', error.error.message);
    // } else {
    //   // The backend returned an unsuccessful response code.
    //   // The response body may contain clues as to what went wrong,
    //   console.error(
    //     `Backend returned code ${error.status}, ` +
    //     `body was: ${error.error}`);
    // }
    // // return an observable with a user-facing error message
    return throwError(
      error.error["message"]);
  };
}
