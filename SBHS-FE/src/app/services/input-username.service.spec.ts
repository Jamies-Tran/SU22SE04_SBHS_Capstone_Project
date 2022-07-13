import { TestBed } from '@angular/core/testing';

import { InputUsernameService } from './input-username.service';

describe('InputUsernameService', () => {
  let service: InputUsernameService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(InputUsernameService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
