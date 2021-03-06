import React from 'react';
import {Field} from "formik";

export const MoneyInputField = ({label, fieldName}) => {
    const renderInput = () => (
        <div className="input-group ml-3" style={{maxWidth: "11rem"}}>
            <div className="input-group-prepend">
                <div className="input-group-text">£</div>
            </div>
            <Field id={fieldName} type="number" className="form-control" name={fieldName}/>
        </div>
    );

    return <FormField label={label} renderValueComponent={renderInput}/>
};

export const InfoField = ({label, value}) => {
    const renderInfoValue = () => (
        <div className="input-group px-2 ml-3"
             style={{
                 maxWidth: "6rem",
                 border: "2px solid black",
                 borderRadius: "5px",
                 backgroundColor: "#f5ea9a"
             }}>
            <strong>{value}</strong>
        </div>
    );

    return <FormField label={label} renderValueComponent={renderInfoValue}/>
};

const FormField = ({label, renderValueComponent}) => (
    <div className="d-flex justify-content-between my-3">
        <label className="align-self-center" style={{fontWeight: "bold", whiteSpace: "nowrap", marginBottom: "0"}}>
            {label}:
        </label>
        {renderValueComponent()}
    </div>
);