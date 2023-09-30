import myCharts from "../myCharts";
import { Line } from 'react-chartjs-2';

export default class LineChartSec extends myCharts {

  constructor(props) {
    super(props);
    this.state = {
        myData: [],
    }
}
componentDidMount() {
  fetch(`http://localhost:5000/api/usagecpu`)
  .then(response => response.json())
  .then(response => this.setState({myData: response}));
}

  render() {
    const options = {
      responsive: true,
      plugins: {
        // legend: {
        //   position: 'top' as const,
        // },
        title: {
          display: true,
        },
      },
    };
    
    const labels = this.state.myData;
    
    const data = {
      labels,
      datasets: [
        {
          label: 'Mise à jour',
          data: this.state.myData,
          borderColor: 'rgb(255, 99, 132)',
          backgroundColor: 'rgba(255, 99, 132, 0.5)',
        },
      ],
    };

    return (
      <>
        <span>-</span>
        <Line options={options} data={data} />
      </>
    );
  }
}