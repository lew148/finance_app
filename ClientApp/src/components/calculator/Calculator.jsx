import React, {useEffect, useState} from 'react';
import {Form, Formik} from 'formik';
import Api from "../../Api";
import CalcIncome from "./CalcIncome";
import CalcSavings from "./CalcSavings";

const Calculator = () => {
    const [expensesTotal, setExpensesTotal] = useState(null)

    useEffect(() => {
        const getExpensesTotal = async () => {
            const response = await Api.getExpensesTotal();
            setExpensesTotal(response.data);
        };
        getExpensesTotal();
    }, []);

    const onGoButtonClick = () => {
    }

    const CalcForm = ({values, setFieldValue}) => (
        <Form>
            <div className="d-flex justify-content-center">
                <div>
                    <div style={{
                        border: "1.25px solid black",
                        borderRadius: "10px",
                        maxWidth: "fit-content"
                    }}>
                        <div className="d-flex justify-content-center">
                            <div className="align-self-center">
                                <h1>Calculator</h1>
                            </div>
                        </div>

                        <hr/>

                        <div className="m-3" style={{minWidth: "max-content"}}>
                            {expensesTotal && (<>
                                <CalcIncome expensesTotal={expensesTotal}/>
                                <hr/>
                                <CalcSavings values={values} setFieldValue={setFieldValue} expensesTotal={expensesTotal}/>
                            </>)}
                        </div>

                        <hr/>

                        <div className="d-flex justify-content-end">
                            <div className="m-3">
                                <button type="button" onClick={onGoButtonClick} className="btn btn-success">Go</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </Form>
    );

    return (
        <div>
            <Formik
                initialValues={{}}
                onSubmit={(results) => console.log(results)}
                component={CalcForm}
            />
        </div>
    );
}

export default Calculator;
