import React, {useEffect, useState} from 'react';
import Api from "../../Api";
import {InfoField, MoneyInputField} from "./CalculatorFields";

const CalcSavings = ({values, setFieldValue, expensesTotal}) => {
    const [savingsPercentage, setSavingsPercentage] = useState(null);

    const maxSavings = (values.amount - expensesTotal).toFixed(2);
    const getSuggestedSavings = () => ((values.amount - expensesTotal) * (savingsPercentage / 100)).toFixed(2);

    useEffect(() => {
        const getSavingsPercentage = async () => {
            const response = await Api.getSavingsPercentage();
            setSavingsPercentage(response.data);
        };
        getSavingsPercentage();
    }, []);

    const useSuggested = () => {
        setFieldValue('savings', getSuggestedSavings());
    }

    const useMax = () => {
        setFieldValue('savings', maxSavings);
    }

    const defaultIfNanOrNegative = (value) => isNaN(value) || value < 0 ? " ----.----" : value;

    return (
        <div className="d-flex justify-content-start">
            <div>
                <InfoField label="Max Savings" value={"£" + defaultIfNanOrNegative(maxSavings)}/>
                <InfoField label="Suggested Savings" value={"£" + defaultIfNanOrNegative(getSuggestedSavings())}/>
                <div className="d-flex justify-content-around my-3">
                    <input type="button" value="Use Suggested" className="btn btn-info" onClick={useSuggested}/>
                    <input type="button" value="Use Max" className="btn btn-info" onClick={useMax}/>
                </div>
                <MoneyInputField label="Amount to Save" fieldName="savings"/>
            </div>
        </div>
    );

}

export default CalcSavings;