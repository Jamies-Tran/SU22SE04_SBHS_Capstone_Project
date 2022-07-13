import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { RegisterComponent } from './register/register.component';
import { WelcomeComponent } from './welcome/welcome.component';
import { LandlordComponent } from './landlord/landlord.component';

const routes: Routes = [
  {path: '', component: WelcomeComponent},
  {path: 'Login', component: LoginComponent},
  {path: 'Register', component: RegisterComponent},
  { path: 'Landlord', component: LandlordComponent },
  {
    path: 'Landlord',
    loadChildren: () =>
      import('./landlord/landlord.module').then((m) => m.LandlordModule),
  },
  {
    path: 'Landlord',
    loadChildren: () =>
      import('./landlord/landlord-routing.module').then((m) => m.LandlordRoutingModule),
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
