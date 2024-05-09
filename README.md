<br/>
<p align="center">
    <a href="https://www.witboost.com">
        <img src="images/witboost_logo.svg" alt="witboost" width=600 >
    </a>
</p>
<br/>

Designed by [Agile Lab](https://www.agilelab.it/), Witboost is a versatile platform that addresses a wide range of sophisticated data engineering challenges. It enables businesses to discover, enhance, and productize their data, fostering the creation of automated data platforms that adhere to the highest standards of data governance. Want to know more about Witboost? Check it out [here](https://www.witboost.com) or [contact us!](https://witboost.com/contact-us).

# Witboost Template Gallery

- [Overview](#overview)
- [Usage](#usage)


## Overview

This repository contains the CUE policies that can be used in Witboost either as-is or as a starting point for your custom policies.

## Usage

-  Clone the project locally to have all the governance policies available to you locally.
-  Update the following:
    - The bucket name for the Airflow policy (field is `bucketName`); use the proper one for the environment the policy will be used in
-  Go to Witboost UI and open Governance > Registry.
-  For each policy, click on the **Create Policy** button located in the upper right corner of the policy list and follow the appropriate steps depending on the policy type:
- Global policy:
  1. Fill out the menu with "Name" and "Description" as General Policy, on the "Environment" drop down choose the environment, in this case it's `development`.
  2. Select "Resource Type" as `Data Product`, "Context" as `global`, "Trigger" as `Active`, "Timing" as `Deployment`, "Engine" as `Cue`, "Resource Preprocessing" as `Default`, "Severity" as `error`.
  3. Leave Infrastructure Template empty.
  4. Select "Interaction Type" as `User to Platform`.
  5. Click on "Next Step" and on the Engine Metadata click on the "Upload CUE" button in the upper right corner and upload the `global_policy.cue` file.
  6. Click on "Next Step" and if all the information is correct, hit save. The policy should appear in the list in the "Draft" status.
  7. Click on the contextual menu (three buttons to the right) and change the status to "Grace" and then to "Enabled".
- Components policies:
  1. Fill out the menu with "Name" and "Description" appropriate with the component policy, on the "Environment" drop down choose the environment, in this case it's `development`.
  2. Select the same fields as step 2 in Global Policy.
  3. Select Infrastructure Template and Use Case Template based on the Component Policy you're registering. This means choosing the infrastructure template you used for Snowflake for Snowflake components, with the specific component use case template Storage Area or Output Port, etc.
  4. Select the same as step 4 in Global Policy.
  5. Repeat steps 5-7 as for the Global Policy but with the appropriate CUE file.


To view the actual CUE Policies written for various technologies, check them out [here](./actual_policies).

For information about a CUE Policies in general and various examples, see [here](./examples).

## License

This project is available under the [Apache License, Version 2.0](https://opensource.org/licenses/Apache-2.0); see [LICENSE](LICENSE) for full details.

## About us

<p align="center">
    <a href="https://www.agilelab.it">
        <img src="images/agilelab_logo.svg" alt="Agile Lab" width=600>
    </a>
</p>

Agile Lab creates value for its Clients in data-intensive environments through customizable solutions to establish performance driven processes, sustainable architectures, and automated platforms driven by data governance best practices.

Since 2014 we have implemented 100+ successful Elite Data Engineering initiatives and used that experience to create Witboost: a technology-agnostic, modular platform, that empowers modern enterprises to discover, elevate and productize their data both in traditional environments and on fully compliant Data mesh architectures.

[Contact us](https://www.agilelab.it/contacts) or follow us on:
  - [LinkedIn](https://www.linkedin.com/company/agile-lab/)
  - [Instagram](https://www.instagram.com/agilelab_official/)
  - [YouTube](https://www.youtube.com/channel/UCTWdhr7_4JmZIpZFhMdLzAA)
  - [Twitter](https://twitter.com/agile__lab)
