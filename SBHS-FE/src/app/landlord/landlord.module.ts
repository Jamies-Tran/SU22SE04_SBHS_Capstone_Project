import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

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
    LandlordRoutingModule
  ]
})
export class LandlordModule { }
