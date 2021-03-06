import React, {useEffect, useState} from 'react';
import Api from "../../Api";
import {InfoField, MoneyInputField} from "./CalculatorFields";

const CalcStep2 = ({values, setFieldValue, expensesTotal}) => {
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

    return (<>
        <div className="d-flex justify-content-center">
            <div>
                <InfoField label="Max Savings (After Expenses)" value={"£" + maxSavings}/>
                <InfoField label="Suggested Savings" value={"£" + (savingsPercentage !== null
                    ? getSuggestedSavings()
                    : 'loading...')}/>
                <div className="d-flex justify-content-around my-3">
                    <input type="button" value="Use Suggested" className="btn btn-info" onClick={useSuggested}/>
                    <input type="button" value="Use Max" className="btn btn-info" onClick={useMax}/>
                </div>
                <MoneyInputField label="Amount to save" fieldName="savings"/>
            </div>
        </div>
    </>);

}

export default CalcStep2;