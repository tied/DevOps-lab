## StreamCo Orchestration
Running the same CloudFormation script using Terraform.

Deploys:
- Application LB (Listener, Target Group, ALB, Assignment, Healcheck, Certificate)
- Autoscaling Group (Bootstrapped Puppet Configuration)
- Route 53 record (streamco.rorychatterton.com)
