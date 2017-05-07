StreamCo DevOps Lab
==========

Technical assessment for DevOps candidates.

App url https://stan.rorychatterton.com
api key in email.

vm ips: 54.179.156.179, 52.221.198.24

DB URL: db.stan.rorychatterton.com
vms and machines Publically accessible for dev testing. would close down with nsg in prod.

App Deployment:
Cloudformation/terraform uses userdata to bootstrap puppet (pulling config from git as I don't have Puppet Enterprise).
Puppet installs and manages docker + local firewall
Docker-Compose Runs Nginx + App Server

App Server Configuration that gets pulled down by the userdata sits in another git repository:
https://github.com/rorychatt/Streamco-AppServer

You can see my extremely simple flask app that returns instance_id & a table from a postgres database in /demoapp/

Basic Goals
==========
- [x] Using AWS Cloudformation, automate the deployment of secure, publicly available HA Load-Balanced Web Servers that return the instance id of the host that served the request.
	- Cloudformation template in /CloudFormation/ . This configuration only covers the basic 2 ALB load balanced application. I have build in the more complicated additional challenges logic into a Terraform configuration found in /terraform/. It was much quicker for me to prototype in a language I'm familiar, and find the TF syntax system much nicer to work with. If you would like me to fully flesh out the Cloudformation, let me know.
- [x] Ensure that the web servers are available in two AWS availability zones and will automatically rebalance themselves if there is no healthy web server instance in either availability zone.
- [x] Redirect any HTTP requests to HTTPS. Self-signed certificates are acceptable.
- [x] Answer the question: "How would you further automate the management of the infrastructure if given unlimited time and resource?"
	- Create a Base AMI with Puppet installed using Packer
	- Service Discovery with Consul
	- Secrets Management with Vault (for non IAM type secrets). Currently passing secrets in code (BAD)
	- App Build Pipeline with Jenkins/GoCD/Bamboo instead of simple TravisCI unit testing
	- Create Blue:Green environments for app deployment
	- Separate App & Infrastructure management by leveraging Kubernetes or Nomad Docker Cluster
	- Integration with Splunk/Elk for logging
	- Upload Static Assets up to S3/CloudFront
	- more in depth app unit testing
	- More practice with Puppet (former company used chef so I am sloppy)


Additional Challenges:
==========

- [x] Drive the deployment with Puppet.
		Puppet Master @ https://puppet.rorychatterton.com
		driven using a mix of puppet & Docker

- [x] Provide basic automated tests to cover included scripts, templates, manifests, recipes, code etc.
	rspec in puppet folder.

- [x] Redirect any 404 errors to a custom static page.
    - https://streamco-test.rorychatterton.com/this_url_will_fail

- [x] Add a Database to your automation and have your application serve the data stored in addition to the instance ID.

Output
==========

Please provide us with:

1. a public URL for hitting the web server deployment.
2. a set of read-only AWS access credentials (Access Key and Secret Key) allowing us to see the AWS resources used in the deployment.
3. SSH key pairs for logging onto the web instances used in the deployment.
4. any scripts, config files, manifests, recipes, or source code you used to achieve the goal above.
5. any detailed notes, written explanations, diagrams, screen shots to help demonstrate your work.
6. written answers to the question: "How would you further automate the management of the infrastructure?"

You can send these as:

* A public GitHub/Bitbucket repository URL.
* A zipped file via e-mail.
* A zipped file via URL download link.

You may tear down the environment once we have confirmed the completion of our review.
