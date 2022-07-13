import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ForgetPasswordRoutingModule } from './forget-password-routing.module';
import { InputUsernameComponent } from './input-username/input-username.component';
import { InputOtpComponent } from './input-otp/input-otp.component';
import { InputPasswordComponent } from './input-password/input-password.component';


@NgModule({
  declarations: [
    InputUsernameComponent,
    InputOtpComponent,
    InputPasswordComponent
  ],
  imports: [
    CommonModule,
    ForgetPasswordRoutingModule
  ]
})
export class ForgetPasswordModule { }
