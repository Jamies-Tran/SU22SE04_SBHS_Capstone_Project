import { Component, OnInit } from '@angular/core';
import { EChartsOption } from 'echarts';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {

  constructor() { }

  ngOnInit(): void {
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


        data: [120, 132, 101, 134, 90, 230, 210, 120, 132, 101, 134, 90, 230],
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
