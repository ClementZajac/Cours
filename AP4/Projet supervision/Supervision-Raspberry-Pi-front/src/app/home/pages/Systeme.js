import { createRef, Component } from 'react';
import { Link } from "react-router-dom";
import LineChart from './LineChart';
import HorizontalBarChart from './HorizontalBarChart';
export default class Systeme extends Component {

	render() {
		return (
			<div className="">
				<div>
					<div className="topResumeElementTitle">
						<h2>Système</h2>
					</div>
					<div className="topResumeElementLink">
					<Link className='btn btn-link' to="/systeme">Détails</Link>
					</div>
				</div>
				<div className="clear"></div>

				<div className="grilleLight">
					<LineChart apiUrn={"temperature"} myLabel={"Temperature en °C"} myBorderColor={"rgb(255, 99, 132)"} myBackgroundColor={"rgba(255, 99, 132, 0.5)"} />
				</div>
				<div className="grilleLight">
					<LineChart apiUrn={"usagecpu"} myLabel={"Charge CPU en %"} myBorderColor={"rgb(255, 99, 132)"} myBackgroundColor={"rgba(255, 99, 132, 0.5)"}/>
				</div>
				<div className="grilleFullWeight">
					<div className="contentGrilleFullWeight">
						<HorizontalBarChart />
					</div>
				</div>
			</div>
		);
	}
}
