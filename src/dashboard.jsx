import React from 'react';

import DeviceList from './List.js'
import './dashboard.css';

class Dashboard extends React.Component {
    render() {
        return(
            <div>
                <h1>Device States</h1>
                <br />
                <DeviceList />
            </div>
        );
    }
}

export { Dashboard };