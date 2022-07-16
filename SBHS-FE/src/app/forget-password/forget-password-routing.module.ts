import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { InputPasswordComponent } from './input-password/input-password.component';
import { InputOtpComponent } from './input-otp/input-otp.component';
import { InputUsernameComponent } from './input-username/input-username.component';
import { ForgetPasswordComponent } from './forget-password.component';

const routes: Routes = [
  {
    path: '',
    component: ForgetPasswordComponent,
    children: [

      { path: 'Step1', component: InputUsernameComponent },
      { path: 'Step2', component: InputOtpComponent },
      { path: 'Step3', component: InputPasswordComponent },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ForgetPasswordRoutingModule { }
