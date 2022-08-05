import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LandlordComponent } from './landlord.component';
import { DashboardComponent } from './dashboard/dashboard.component';
import { RegisterHomestayComponent } from './register-homestay/register-homestay.component';
import { ProfileComponent } from './profile/profile.component';
import { BookingComponent } from './booking/booking.component';
import { BookingDetailComponent } from './booking/booking-detail/booking-detail.component';



const routes: Routes = [
  {
    path: '',
    component: LandlordComponent,
    children: [

      { path: 'Dashboard', component: DashboardComponent },
      { path: 'RegisterHomestay', component: RegisterHomestayComponent },
      { path: 'Profile', component: ProfileComponent },
      { path: 'Booking', component: BookingComponent },
      { path: 'Booking', children:[
        { path: 'BookingDetail', component: BookingDetailComponent },
      ] },

    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class LandlordRoutingModule {}
