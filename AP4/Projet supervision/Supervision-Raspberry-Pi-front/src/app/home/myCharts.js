
import { Component } from 'react';
import Chart from 'chart.js/auto';
import { ArcElement} from 'chart.js';
Chart.register(ArcElement);

export default class myCharts extends Component {

    state = {
        width: 0, height: 0
    };

    componentWillUnmount() {
        window.removeEventListener('resize', this.updateDimensions);
    }

    componentDidMount() {
        window.addEventListener('resize', this.updateDimensions);
    }

    updateDimensions = () => {
        this.setState({ width: window.innerWidth, height: window.innerHeight });
    };

}
