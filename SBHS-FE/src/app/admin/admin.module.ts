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

import { RequestComponent } from './request/request.component';
import { RequestAccountComponent } from './request/request-detail/request-account/request-account.component';
import { MatButtonModule } from '@angular/material/button';

@NgModule({
  declarations: [RequestComponent, RequestAccountComponent],
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
  ],
})
export class AdminModule {}
