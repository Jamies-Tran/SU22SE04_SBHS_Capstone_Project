import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LandlordComponent } from './landlord.component';
import { DashboardComponent } from './dashboard/dashboard.component';
import { RegisterHomestayComponent } from './register-homestay/register-homestay.component';
import { Page1Component } from '../page1/page1.component';


const routes: Routes = [
  {
    path: '',
    component: LandlordComponent,
    children: [

      { path: 'Dashboard', component: DashboardComponent },
      { path: 'RegisterHomestay', component: RegisterHomestayComponent },
      { path: 'Page1', component: Page1Component },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class LandlordRoutingModule {}
