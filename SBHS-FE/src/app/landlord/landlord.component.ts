import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-landlord',
  templateUrl: './landlord.component.html',
  styleUrls: ['./landlord.component.scss']
})
export class LandlordComponent implements OnInit {

  constructor(private router: Router,private route: ActivatedRoute) { }
  public username = localStorage.getItem("username")
  ngOnInit(): void {
  }
  public logout(){
    localStorage.clear();
    this.router.navigate(['/Login'], {relativeTo: this.route});
  }
}
