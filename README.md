# CuePolicies

This repository contains the CUE policies used in the sandbox/playground environments as a starting point.

## Usage

1. Clone the project locally to have all the governance policies available to you locally.
2. Go to Witboost UI and open Governance > Registry.
3. For each policy click on the "Create Policy" button located on the upper right corner of the policy list and follow the approriate steps depending on the policy type:
- Global policy:
  1. Fill out the menu with "Name" and "Description" as General Policy, on the "Environment" drop down choose the environment, in this case it's `development`.
  2. Select "Resource Type" as `Data Product`, "Context" as `global`, "Trigger" as `Active`, "Timing" as `Deployment`, "Engine" as `Cue`, "Resource Preprocessing" as `Default`, "Severity" as `error`.
  3. Leave Infrastructure Template empty.
  4. Select "Interaction Type" as `User to Platform`.
  5. Click on "Next Step" and on the Engine Metadata click on the "Upload CUE" button on the upper right corner and upload the `global_policy.cue` file. 
  6. Click on "Next Step" and if all the information is correct, hit save. The policy should appear in the list in the "Draft" status.
  7. Click on the contextual menu (three buttons to the right) and change the status to "Grace" and then to "Enabled".
- Components policies:
  1. Fill out the menu with "Name" and "Description" appropriate with the component policy, on the "Environment" drop down choose the environment, in this case it's `development`.
  2. Select the same fields as step 2 in Global Policy.
  3. Select Infrastructure Template and Use Case Template based on the Component Policy you're registering. (Infrastructure template Snowflake for snowflake components, with the specific component use case template Storage or Output Port, etc.).
  4. Select the same as step 4 in Global Policy.
  5. Repeat steps 5-7 as for the Global Policy but with the appropriate CUE file.
