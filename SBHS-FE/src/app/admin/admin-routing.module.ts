import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AdminComponent } from './admin.component';
import { RequestComponent } from './request/request.component';

const routes: Routes = [
  {
    path: '',
    component: AdminComponent,
    children: [

      { path: 'Request', component: RequestComponent },


    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AdminRoutingModule { }
