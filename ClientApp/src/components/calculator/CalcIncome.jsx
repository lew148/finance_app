import React from 'react';
import {InfoField, MoneyInputField} from "./CalculatorFields";

const CalcIncome = ({expensesTotal}) => (<div>
    <InfoField label="Expenses Total" value={"£" + expensesTotal.toFixed(2)}/>
    <MoneyInputField label="Income" fieldName="amount"/>
</div>);

export default CalcIncome;