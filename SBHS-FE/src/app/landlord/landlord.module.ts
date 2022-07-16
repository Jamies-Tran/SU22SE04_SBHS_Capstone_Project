import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgxDropzoneModule } from 'ngx-dropzone';

import { LandlordRoutingModule } from './landlord-routing.module';
import { DashboardComponent } from './dashboard/dashboard.component';
import { RegisterHomestayComponent } from './register-homestay/register-homestay.component';


@NgModule({
  declarations: [
    DashboardComponent,
    RegisterHomestayComponent
  ],
  imports: [
    CommonModule,
    LandlordRoutingModule,
    NgxDropzoneModule
  ]
})
export class LandlordModule { }
