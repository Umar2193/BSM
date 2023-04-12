var morrisChartScripts = function () {

    $(function () {
      var tax_data = [
           {"period": "2014 Q3", "stocka": 2407, "stockb": 1660},
           { "period": "2014 Q2", "stocka": 2151, "stockb": 329 },
           { "period": "2014 Q1", "stocka": 1969, "stockb": 218 },
           { "period": "2013 Q4", "stocka": 1266, "stockb": 361 },
           { "period": "2013 Q3", "stocka": 2161, "stockb": 475 },
           { "period": "2013 Q2", "stocka": 1055, "stockb": 280 },
           { "period": "2013 Q1", "stocka": 1826, "stockb": 650 },
           { "period": "2012 Q4", "stocka": 2250, "stockb": 1000 },
           { "period": "2012 Q3", "stocka": 500, "stockb": 250 }
      ];

      Morris.Line({
        element: 'morris-graph-demo',
        data: tax_data,
        xkey: 'period',
        ykeys: ['stocka', 'stockb'],
        labels: ['Stock A', 'Stock B'],
        lineColors: ['#3498db', '#a9d86e'],
        hideHover: 'auto',
        resize: true
      });

      Morris.Donut({
          element: 'morris-donut-demo',
        data: [
          {label: '.NET', value: 35 },
          {label: 'MVC', value: 30 },
          {label: 'PHP', value: 20 },
          {label: 'Perl', value: 15 }
        ],
        colors: ['#3498db', '#3980B5', '#0B62A4', '#7CB47C'],
        resize: true,
        formatter: function (y) { return y + "%" }
      });

      Morris.Area({
        element: 'morris-area-demo',
        data: [
          { period: '2014 Q3', subscription: 1566, newmembers: 1550, churn: 647 },
          { period: '2014 Q2', subscription: 3470, newmembers: 1224, churn: 2431 },
          { period: '2014 Q1', subscription: 1241, newmembers: 1063, churn: 1521 },
          { period: '2013 Q4', subscription: 2747, newmembers: 4537, churn: 3634 },
          { period: '2013 Q3', subscription: 3800, newmembers: 1213, churn: 2493 },
          { period: '2013 Q2', subscription: 2600, newmembers: 2290, churn: 1993 },
          { period: '2013 Q1', subscription: 5824, newmembers: 4705, churn: 538 },
          { period: '2012 Q4', subscription: 10473, newmembers: 3907, churn: 2373 },
          { period: '2012 Q3', subscription: 9647, newmembers: 2463, churn: 1023 },
          { period: '2012 Q2', subscription: 7422, newmembers: 4703, churn: 1871 }
        ],
          xkey: 'period',
          ykeys: ['subscription', 'newmembers', 'churn'],
          labels: ['Subscription', 'New Members', 'Churn'],
          hideHover: 'auto',
          lineWidth: 1,
          pointSize: 5,
          lineColors: ['#4a8bc2', '#7CB47C', '#2577B5'],
          fillOpacity: 0.5,
          smooth: true,
          resize: true
      });

      Morris.Bar({
        element: 'morris-bar-demo',
        data: [
          { device: 'Subscription', geekbench: 250 },
          { device: 'Members', geekbench: 1950 },
          { device: 'Churn', geekbench: 120 },
          {device: 'Visits', geekbench: 1200},
          {device: 'Calls', geekbench: 750},
        ],
        xkey: 'device',
        ykeys: ['geekbench'],
        labels: ['Geekbench'],
        barRatio: 0.4,
        xLabelAngle: 35,
        hideHover: 'auto',
        barColors: ['#3498db'],
        resize: true
      });

      $('.code-example').each(function (index, el) {
          if (el != null && el.length > 0) {
              eval($(el).text());
          }
      });
    });

}();