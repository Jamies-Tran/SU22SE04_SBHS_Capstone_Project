import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DeleteHomestayComponent } from './delete-homestay.component';

describe('DeleteHomestayComponent', () => {
  let component: DeleteHomestayComponent;
  let fixture: ComponentFixture<DeleteHomestayComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DeleteHomestayComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DeleteHomestayComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
