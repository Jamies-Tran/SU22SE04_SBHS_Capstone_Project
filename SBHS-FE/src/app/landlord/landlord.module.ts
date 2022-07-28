import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgxDropzoneModule } from 'ngx-dropzone';
import {MatStepperModule} from '@angular/material/stepper';
import {CdkStepperModule} from '@angular/cdk/stepper';
import {MatFormFieldModule, MatLabel} from '@angular/material/form-field';
import {MatInputModule} from '@angular/material/input';
import {MatButtonModule} from '@angular/material/button';
import {MatCheckboxModule} from '@angular/material/checkbox';
import {MatRadioModule} from '@angular/material/radio';

import { LandlordRoutingModule } from './landlord-routing.module';
import { DashboardComponent } from './dashboard/dashboard.component';
import { RegisterHomestayComponent } from './register-homestay/register-homestay.component';
import { ProfileComponent } from './profile/profile.component';
import { AngularFireModule } from '@angular/fire/compat';
import { enviroment } from 'src/enviroment/enviroment';
import { initializeApp } from 'firebase/app';



@NgModule({
  declarations: [
    DashboardComponent,
    RegisterHomestayComponent,
    ProfileComponent,

  ],
  imports: [
    CommonModule,
    LandlordRoutingModule,
    NgxDropzoneModule,
    MatStepperModule,
    CdkStepperModule,
    MatFormFieldModule,
    FormsModule,
    ReactiveFormsModule,
    MatInputModule,
    MatButtonModule,
    MatCheckboxModule,
    MatRadioModule,
    AngularFireModule,
    AngularFireModule.initializeApp(enviroment.firebaseConfig) ,
  ]
})
export class LandlordModule { }
