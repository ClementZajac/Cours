import myCharts from "../myCharts";
import { Line } from 'react-chartjs-2';

export default class LineChart extends myCharts {

  constructor(props) {
    super(props);
    this.state = {
        myData: [],
    }

}


componentDidMount() {
  fetch(`http://localhost:5000/api/${this.props.apiUrn}`)
   .then(response => response.json())
   .then(response => this.setState({myData: response}));
}

  render() {
    const options = {
      responsive: true,
      plugins: {
        title: {
          display: true,
        },
      },
      scales: {
        y: {
          min: 0,
          max: 100,
        },
      }
    };
    
    const labels = this.state.myData[1];    
    const data = {
      labels,
      datasets: [
        {
          label : this.props.myLabel,
          data: this.state.myData[0],
          borderColor: this.props.myBorderColor,
          backgroundColor: this.props.myBackgroundColor,
        },
      ],
    };

    return (
      <>
        <span> </span>
        <Line options={options} data={data} />
      </>
    );
  }
}