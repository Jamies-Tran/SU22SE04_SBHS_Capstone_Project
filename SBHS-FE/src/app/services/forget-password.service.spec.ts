import { TestBed } from '@angular/core/testing';

import { ForgetPasswordService } from './forget-password.service';

describe('InputUsernameService', () => {
  let service: ForgetPasswordService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ForgetPasswordService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
