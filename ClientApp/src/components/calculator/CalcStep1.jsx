import React from 'react';
import {InfoField, MoneyInputField} from "./CalculatorFields";

const CalcStep1 = ({expensesTotal}) => (
    <div className="d-flex justify-content-center">
        <div>
            <InfoField label="Expenses Total" value={"£" + expensesTotal.toFixed(2)}/>
            <MoneyInputField label="Income" fieldName="amount"/>
        </div>
    </div>
);

export default CalcStep1;