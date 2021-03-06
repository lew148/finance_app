import React from 'react';
import {Field} from "formik";

export const MoneyInputField = ({label, fieldName}) => (
    <div className="d-flex m-1">
        <label className="align-self-center" style={{fontWeight: "bold", marginBottom: "0"}}>{label}:</label>
        <div className="input-group ml-3" style={{maxWidth: "10rem"}}>
            <div className="input-group-prepend">
                <div className="input-group-text">£</div>
            </div>
            <Field id={fieldName} type="number" className="form-control" name={fieldName}/>
        </div>
    </div>
);

export const InfoField = ({label, value}) => (
    <div className="d-flex my-3">
        <label className="align-self-center"
               style={{fontWeight: "bold", whiteSpace: "nowrap", marginBottom: "0"}}>{label}:</label>
        <div className="input-group px-2 ml-3 align-self-center"
             style={{
                 maxWidth: "6rem",
                 border: "2px solid black",
                 borderRadius: "5px",
                 backgroundColor: "#f5ea9a"
             }}>
            <strong>{value}</strong>
        </div>
    </div>
);