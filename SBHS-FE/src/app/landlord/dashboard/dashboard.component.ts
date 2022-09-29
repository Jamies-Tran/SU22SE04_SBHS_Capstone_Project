import { Component, OnInit } from '@angular/core';
import { EChartsOption } from 'echarts';
import { ServerHttpService } from 'src/app/services/dashboard.service';
import dateFormat, { masks } from "dateformat";
@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss'],
})
export class DashboardComponent implements OnInit {
  constructor(private http: ServerHttpService) {}

  ngOnInit(): void {
    this.getInfoCurrentMonth();
    this.getInfoMonth1();
    this.getInfoMonth2();
    this.getInfoMonth3();
    this.getInfoMonth4();
    this.getInfoMonth5();
    this.getInfoMonth6();
    this.getInfoMonth7();
    this.getInfoMonth8();
    this.getInfoMonth9();
    this.getInfoMonth10();
    this.getInfoMonth11();
    this.getInfoMonth12();
  }
  currentValue:any;
  month1Value:number =0
  month2Value:number =0
  month3Value:number =0
  month4Value:number =0
  month5Value:number =0
  month6Value:number =0
  month7Value:number =0
  month8Value:number =0
  month9Value:number =0
  month10Value:number =0
  month11Value:number =0
  month12Value:number =0
  getInfoCurrentMonth(){
    const now = new Date();
    this.http.getInfoDashboard(dateFormat(now, "yyyy-mm-dd")).subscribe((data =>{
      this.currentValue = data;
      console.log(data.totalProfit)
    }),
    error =>{
      console.log(error)
    })
  }
  getInfoMonth1(){
    this.http.getInfoDashboard("2022-1-01").subscribe((data =>{
      this.month1Value = data.totalProfit;
      console.log(data)
    }),
    error =>{
      console.log(error)
    })
  }
  getInfoMonth2(){
    this.http.getInfoDashboard("2022-2-01").subscribe((data =>{
      this.month2Value = data.totalProfit;
      console.log(data)
    }),
    error =>{
      console.log(error)
    })
  }
  getInfoMonth3(){
    this.http.getInfoDashboard("2022-3-01").subscribe((data =>{
      this.month3Value = data.totalProfit;
      console.log(data)
    }),
    error =>{
      console.log(error)
    })
  }
  getInfoMonth4(){
    this.http.getInfoDashboard("2022-4-01").subscribe((data =>{
      this.month4Value = data.totalProfit;
      console.log(data)
    }),
    error =>{
      console.log(error)
    })
  }
  getInfoMonth5(){
    this.http.getInfoDashboard("2022-5-01").subscribe((data =>{
      this.month5Value = data.totalProfit;
      console.log(data)
    }),
    error =>{
      console.log(error)
    })
  }
  getInfoMonth6(){
    this.http.getInfoDashboard("2022-6-01").subscribe((data =>{
      this.month6Value = data.totalProfit;
      console.log(data)
    }),
    error =>{
      console.log(error)
    })
  }
  getInfoMonth7(){
    this.http.getInfoDashboard("2022-7-01").subscribe((data =>{
      this.month7Value = data.totalProfit;
      console.log(data)
    }),
    error =>{
      console.log(error)
    })
  }
  getInfoMonth8(){
    this.http.getInfoDashboard("2022-8-01").subscribe((data =>{
      this.month8Value = data.totalProfit;
      console.log(data)
    }),
    error =>{
      console.log(error)
    })
  }
  getInfoMonth9(){
    this.http.getInfoDashboard("2022-9-01").subscribe((data =>{
      this.month9Value = data.totalProfit;
      console.log(this.month9Value)
    }),
    error =>{
      console.log(error)
    })
  }
  getInfoMonth10(){
    this.http.getInfoDashboard("2022-10-01").subscribe((data =>{
      this.month10Value = data.totalProfit;
      console.log(data)
    }),
    error =>{
      console.log(error)
    })
  }
  getInfoMonth11(){
    this.http.getInfoDashboard("2022-11-01").subscribe((data =>{
      this.month11Value = data.totalProfit;
      console.log(data)
    }),
    error =>{
      console.log(error)
    })
  }
  getInfoMonth12(){
    this.http.getInfoDashboard("2022-12-01").subscribe((data =>{
      this.month12Value = data.totalProfit;
      console.log(data)
    }),
    error =>{
      console.log(error)
    })
  }
  profits: EChartsOption = {
    title: {
      text: 'Monthly Analytics',
    },
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'cross',
        label: {
          backgroundColor: '#6a7985',
        },
      },
    },
    legend: {
      data: ['Profits'],
    },
    toolbox: {
      feature: {
        restore: { show: true },
        saveAsImage: {},
      },
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      containLabel: true,
    },
    xAxis: [
      {
        type: 'category',
        boundaryGap: false,
        data: [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ],
      },
    ],
    yAxis: [
      {
        type: 'value',
        name: 'money',
        position: 'left',
        alignTicks: true,
        axisLine: {
          show: true,
        },
        axisLabel: {
          formatter: '{value} $',
        },
      },
    ],
    series: [
      {
        name: 'Profits',
        type: 'line',
        stack: 'Total',
        tooltip: {
          valueFormatter: function (value) {
            return value + ' $';
          },
        },
        emphasis: {
          focus: 'series',
        },


        data: [this.month1Value, this.month2Value, this.month3Value, this.month4Value, this.month5Value, this.month6Value, this.month7Value, this.month8Value, this.month9Value, this.month10Value, this.month11Value, this.month12Value, 230],
      },
    ],
  };

  //  blue , green , red
  bookingColor = ['#5470C6', '#91CC75', '#EE6666'];
  bookings: EChartsOption = {
    title: {
      text: 'Total Booking',
    },
    color: this.bookingColor,
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'cross',
        crossStyle: {
          color: '#999',
        },
      },
    },
    toolbox: {
      feature: {
        dataView: { show: true, readOnly: false },
        magicType: { show: true, type: ['line', 'bar'] },
        restore: { show: true },
        saveAsImage: { show: true },
      },
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      containLabel: true,
    },
    legend: {
      data: ['Success', 'Cancel', 'Total Booking'],
    },
    xAxis: [
      {
        type: 'category',
        data: [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ],
        axisPointer: {
          type: 'shadow',
        },
      },
    ],
    yAxis: [
      {
        type: 'value',
        name: 'Amount',
        min: 0,
        axisLine: {
          show: true,
        },
        axisLabel: {
          formatter: '{value}',
        },
      },
    ],
    series: [
      {
        name: 'Success',
        type: 'bar',
        color: this.bookingColor[1],
        data: [
          2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3,
        ],
      },
      {
        name: 'Cancel',
        type: 'bar',
        color: this.bookingColor[2],
        data: [
          2.0, 2.2, 3.3, 4.5, 6.3, 10.2, 20.3, 23.4, 23.0, 16.5, 12.0, 6.2,
        ],
      },
      {
        name: 'Total Booking',
        type: 'line',
        color: this.bookingColor[0],
        data: [
          2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3,
        ],
      },
    ],
  };
}
