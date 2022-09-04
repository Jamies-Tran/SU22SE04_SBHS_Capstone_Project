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
import {MatSelectModule} from '@angular/material/select';
import {MatRippleModule} from '@angular/material/core';
import {MatPaginatorModule} from '@angular/material/paginator';
import { DashboardComponent } from './dashboard/dashboard.component';
import { RegisterHomestayComponent } from './register-homestay/register-homestay.component';
import { ProfileComponent } from './profile/profile.component';
import { AngularFireModule } from '@angular/fire/compat';
import {MatDialogModule} from '@angular/material/dialog';
import {MatProgressSpinnerModule} from '@angular/material/progress-spinner';
import { NgxPaginationModule } from 'ngx-pagination';
import {MatExpansionModule} from '@angular/material/expansion';
import {MatIconModule} from '@angular/material/icon';
import { NgxEchartsModule } from 'ngx-echarts';

import { enviroment } from 'src/enviroment/enviroment';
import { initializeApp } from 'firebase/app';
import { BookingComponent } from './booking/booking.component';
import { BookingDetailComponent } from './booking/booking-detail/booking-detail.component';
import { NgxEditorModule } from 'ngx-editor';
import { GooglePlaceModule } from 'ngx-google-places-autocomplete';



@NgModule({
  declarations: [
    DashboardComponent,
    RegisterHomestayComponent,
    ProfileComponent,
    BookingComponent,
    BookingDetailComponent,

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
    MatSelectModule,
    MatRippleModule,
    MatPaginatorModule,
    MatDialogModule,
    MatProgressSpinnerModule,
    NgxPaginationModule,
    MatExpansionModule,
    MatIconModule,
    NgxEditorModule,
    NgxEchartsModule.forRoot({ echarts: () => import('echarts') }),
    GooglePlaceModule
  ]
})
export class LandlordModule { }
