import { Component, OnInit } from '@angular/core';
import { FirebaseError, initializeApp } from 'firebase/app';
import { FirebaseApp } from 'firebase/app';

@Component({
  selector: 'app-request-account',
  templateUrl: './request-account.component.html',
  styleUrls: ['./request-account.component.scss'],
})
export class RequestAccountComponent implements OnInit {
  constructor() {}

  ngOnInit(): void {}
}
const firebaseConfig = {
  apiKey: 'AIzaSyAhXRZmd_yo9BuPi3MZzX2svj7E5M72vaI',
  authDomain: 'stay-with-me-356017.firebaseapp.com',
  projectId: 'stay-with-me-356017',
  storageBucket: 'stay-with-me-356017.appspot.com',
  messagingSenderId: '593303082715',
  appId: '1:593303082715:web:4e610a7104a49b8cfa1efe',
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);


