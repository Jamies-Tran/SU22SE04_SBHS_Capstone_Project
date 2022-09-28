import { Component, OnInit } from '@angular/core';
import { Editor, Toolbar } from 'ngx-editor';
import { ServerHttpService } from 'src/app/services/homestay.service';
import { ImageService } from '../../../services/image.service';
import { Options } from 'ngx-google-places-autocomplete/objects/options/options';

@Component({
  selector: 'app-homestay-detail',
  templateUrl: './homestay-detail.component.html',
  styleUrls: ['./homestay-detail.component.scss'],
})
export class HomestayDetailComponent implements OnInit {
  // image
  homestayImage: any[] = [];
  homestayLicense: any;
  i: any;
  check = false;
  constructor(private http: ServerHttpService, private image: ImageService) {}
  value: any;
  ListSpecialDay: any[] = [];
  imgUrl !: string;
  ngOnInit(): void {
    this.editor = new Editor();
    this.http.getHomestayDetail().subscribe(async (data) => {
      this.value = data;
      console.log(data);
      for(let item of this.value.homestayPriceList){
        if(item.type == 'special'){
          this.ListSpecialDay.push(item);
          console.log(this.ListSpecialDay);
        }
      }



      for (this.i of this.value.homestayImages) {
        this.imgUrl = await this.image.getImage('homestay/' + this.i.url);
        this.homestayImage.push({url: this.imgUrl})
        console.log("image", this.imgUrl)
      }
      this.homestayLicense = await this.image.getImage('homestay/' + this.value.homestayLicense.url);
    });
  }

  // richtext
  editor!: Editor;

  toolbar: Toolbar = [
    ['bold', 'italic'],
    ['underline', 'strike'],
    ['code', 'blockquote'],
    ['ordered_list', 'bullet_list'],
    [{ heading: ['h1', 'h2', 'h3', 'h4', 'h5', 'h6'] }],
    ['link', 'image'],
    ['text_color', 'background_color'],
    ['align_left', 'align_center', 'align_right', 'align_justify'],
  ];
  // Format Month
  valueMonthName: Array<string> = [
    'January ',
    'February ',
    'March ',
    'April ',
    'May ',
    'June ',
    'July',
    'August',
    'September',
    'October',
    'November ',
    'December ',
  ];

  // API Google Map

  formattedaddress = ' ';
  options = {
    types: ['address'],
    componentRestrictions: {
      country: ['VN'],
    },
  } as unknown as Options;
  public handleAddressChange(address: any) {
    //setting address from API to local variable
    this.formattedaddress = address.formatted_address;
    console.log('address', address);
  }
}
