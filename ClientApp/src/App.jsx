import React from 'react';
import { Route } from 'react-router';
import Layout from './components/Layout';
import Calculator from './components/calculator/Calculator';
import Expenses from './components/expenses/Expenses';

import './custom.css'

const App = () => (
    <Layout>
        <Route exact path='/' component={Calculator} />
        <Route exact path='/expenses' component={Expenses} />
    </Layout>
);

export default App;
