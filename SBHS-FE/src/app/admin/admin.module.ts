import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatTableModule } from '@angular/material/table';
import { NgxDropzoneModule } from 'ngx-dropzone';
import { CdkTableModule } from '@angular/cdk/table';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSortModule } from '@angular/material/sort';
import { AdminRoutingModule } from './admin-routing.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatInputModule } from '@angular/material/input';
import { NgxPaginationModule } from 'ngx-pagination';

import { RequestComponent } from './request/request.component';
import { RequestAccountComponent } from './request/request-detail/request-account/request-account.component';
import { MatButtonModule } from '@angular/material/button';
import { RequestHomestayComponent } from './request-homestay/request-homestay.component';
import { RequestHomestayDetailComponent } from './request-homestay/request-homestay-detail/request-homestay-detail.component';
import { MatStepperModule } from '@angular/material/stepper';

@NgModule({
  declarations: [RequestComponent, RequestAccountComponent, RequestHomestayComponent, RequestHomestayDetailComponent],
  imports: [
    CommonModule,
    AdminRoutingModule,
    MatTableModule,
    NgxDropzoneModule,
    CdkTableModule,
    MatPaginatorModule,
    MatFormFieldModule,
    FormsModule,
    ReactiveFormsModule,
    MatInputModule,
    MatSortModule,
    MatButtonModule,
    MatStepperModule,
    NgxPaginationModule
  ],
})
export class AdminModule {}
