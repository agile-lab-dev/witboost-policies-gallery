# CUE Policy


## Introduction to CUE Language

CUE is an open-source data validation language and inference engine. Although the language is not a general-purpose programming language it supports and simplifies a wide variety of applications, such as **data validation**, **configuration**, **querying** and **code generation**.

The inference engine can be used to validate data in code or to include it as part of a code generation pipeline.

CUE’s design ensures that combining CUE values in any order always gives the same result (it is associative, commutative and idempotent). This makes CUE particularly well-suited for cases where CUE constraints are combined from different sources:

- **Data validation**: different departments or groups can each define their own constraints to apply to the same set of data.
- **Code extraction and generation**: extract CUE definitions from multiple sources (Go code, Protobuf), combine them into a single definition, and use that to generate definitions in another format (e.g. OpenAPI).
- **Configuration**: values can be combined from different sources without one having to import the other.

The ordering of values also allows set containment analysis of entire configurations. Where most validation systems are limited to checking whether a concrete value matches a schema, CUE can validate whether any instance of one schema is also an instance of another (as well as handle checks such that verifying that it is it backwards compatible), or compute a new schema that represents all instances that match two other schema.

## Properties of CUE Language

Some of the important properties of CUE Language are listed below:

- **JSON Superset**: In its simplest form, CUE is a superset of JSON. It means that **all valid JSON is CUE but not vice-versa**.
- **Types are values**: CUE merges the concepts of values and types. Essentially, in CUE, _types are values_.
- **Duplicate Fields**: CUE allows fields to be specified multiple times, so long as all the values don't conflict. If the values don't conflict, we say they **unify** successfully.

> Unification: It is the process of checking that values don’t conflict, and it happens implicitly whenever any field is redeclared.

- **Constraints**: It specifies what values are allowed. Constraints are values because all **types are values**. Constraints can **reduce boilerplate** and simplify the specification of data. If a constraint specifies a field then the field and its value are present everywhere the constraint is unified, and don’t need to be repeated.
- **Definitions**: In CUE, schemas are typically written as **definitions**. A definition is a field whose identifier starts with ```#``` or ```_#```. 
- **Validation**: Constraints can be used to **validate** values of concrete instances. They can be applied to data from any source, whether held in CUE, YAML, JSON, or elsewhere.
- **Order is Irrelevant**: CUE’s core operations are defined so that the order in which configurations are combined is unimportant. We say that **order is irrelevant** in CUE. This crucial property explains how CUE is able to handle a field being specified **multiple times**. Because each occurrence of a field is as important as every other, all occurrences must not conflict with each other.

To know more about the CUE Language and its features, check it out [here](https://cuelang.org/docs/tutorial/).

## Examples

In this section, we provide various examples for specific use-cases which could be useful in your own journey of creating CUE Policies within Witboost.

These examples are meant to be a more hands-on and code-ready experience than the Witboost documentation on the customization of templates, but the latter still acts as a valuable comprehensive resource on how to configure each type of field.

- **[Output Port breaking change detection](./OutputPort_breaking_change_detection)**: This policy blocks new minor/patch versions of a DP that change OP in an incompatible way, e.g. removing one or more.
- **[GDPR checks](./GDPR_checks)**: This one inspects the tags for the DP and its OP and makes sure that if a column exists that is marked as being PII via the tag, the DP has the GDPR tag.
- **[Sample data check](./Sample_data_check)**: This policy simply makes sure that sample data is provided for each OP. It can be set to warning severity toi remind developers to add it without impeding deployment, and can be set to error in production envs to make sure they are indeed present.