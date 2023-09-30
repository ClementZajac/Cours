

import myCharts from "../myCharts";
import { Bar } from "react-chartjs-2";
export default class HorizontalBarChart extends myCharts {

  constructor(props) {
        super(props);
        this.state = {
            myData: [],
        }
  }
  
  componentDidMount() {
    this.getUsageStorage();
  }
  
  getUsageStorage() {
    fetch(`http://localhost:5000/api/usagestorage`)
    .then(response => response.json())
    .then(response => response[0].usagestorage)
    .then(response => this.setState({myData: response}));
  }

  render() {
    const options = {
      indexAxis: 'y',
      elements: {
        bar: {
          borderWidth: 2,
        },
      },
      responsive: true,
      plugins: {
        title: {
          display: true,
          text: '',
        },
      },
    };
    
    const labels = [''];
    
    const data = {
      labels,
      datasets: [
        {
          label: 'Stockage en %', 
          data: [this.state.myData,100],
          borderColor: 'rgb(255, 99, 132)',
          backgroundColor: 'rgba(255, 99, 132, 0.5)',
        },
      ],
    };

    return (
      <>
        <span> </span>
        <Bar options={options} data={data} />
      </>
    );
  }

}


