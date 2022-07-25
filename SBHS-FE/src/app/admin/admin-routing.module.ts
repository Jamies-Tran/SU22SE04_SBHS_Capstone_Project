import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AdminComponent } from './admin.component';
import { RequestComponent } from './request/request.component';
import { RequestAccountComponent } from './request/request-detail/request-account/request-account.component';

const routes: Routes = [
  {
    path: '',
    component: AdminComponent,
    children: [

      { path: 'Request', component: RequestComponent },
      { path: 'RequestAccount', component: RequestAccountComponent },


    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AdminRoutingModule { }
