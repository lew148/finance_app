import React from 'react';
import { Route } from 'react-router';
import Layout from './components/Layout';
import Calculator from './components/calculator/Calculator';
import Expenses from './components/expenses/Expenses';
import Records from './components/records/Records';
import Settings from './components/Settings';

import './custom.css'

const App = () => (
    <Layout>
        <Route exact path='/' component={Calculator} />
        <Route exact path='/expenses' component={Expenses} />
        <Route exact path='/records' component={Records} />
        <Route exact path='/settings' component={Settings} />
    </Layout>
);

export default App;
