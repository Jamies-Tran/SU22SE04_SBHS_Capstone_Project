import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.scss']
})
export class AdminComponent implements OnInit {

  constructor(private router: Router,private route: ActivatedRoute) { }

  ngOnInit(): void {
  }
  public logout(){
    localStorage.clear();
    this.router.navigate(['/Login'], {relativeTo: this.route});
  }
}
