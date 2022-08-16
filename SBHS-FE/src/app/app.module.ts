
import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppRoutingModule } from './app-routing.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { NgxDropzoneModule } from 'ngx-dropzone';
import { MatStepperModule } from '@angular/material/stepper';
import { CdkStepperModule } from '@angular/cdk/stepper';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatRadioModule } from '@angular/material/radio';
import { AngularFireModule } from '@angular/fire/compat';
import { AngularFirestoreModule } from '@angular/fire/compat/firestore';
import { AngularFireStorageModule } from '@angular/fire/compat/storage';
import { AngularFireDatabaseModule } from '@angular/fire/compat/database';
import { enviroment } from 'src/enviroment/enviroment';
import {MatSelectModule} from '@angular/material/select';
import {MatRippleModule} from '@angular/material/core';
import {MatIconModule} from '@angular/material/icon';
import {NgxMatFileInputModule} from '@angular-material-components/file-input';
import {MatTableModule} from '@angular/material/table';
import {MatExpansionModule} from '@angular/material/expansion';
import { NgxEditorModule } from 'ngx-editor';


import { AppComponent } from './app.component';
import { LoginComponent } from './login/login.component';
import { RegisterComponent } from './register/register.component';
import { WelcomeComponent } from './welcome/welcome.component';
import { LandlordComponent } from './landlord/landlord.component';
import { ForgetPasswordComponent } from './forget-password/forget-password.component';
import { AdminComponent } from './admin/admin.component';
import { Page1Component } from './page1/page1.component';



@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    RegisterComponent,
    WelcomeComponent,
    LandlordComponent,
    ForgetPasswordComponent,
    AdminComponent,
    Page1Component,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
    BrowserAnimationsModule,

    NgxDropzoneModule,
    MatStepperModule,
    CdkStepperModule,
    MatFormFieldModule,
    ReactiveFormsModule,
    MatInputModule,
    MatButtonModule,
    MatCheckboxModule,
    MatRadioModule,
    AngularFireModule,
    AngularFireModule.initializeApp(enviroment.firebaseConfig) ,
    AngularFireStorageModule,
    AngularFireDatabaseModule,
    AngularFirestoreModule,
    MatSelectModule,
    MatRippleModule,
    MatIconModule,
    NgxMatFileInputModule,
    MatTableModule,
    MatExpansionModule,
    NgxEditorModule

  ],
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}
