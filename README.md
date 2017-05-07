StreamCo DevOps Lab
==========

Technical assessment for DevOps candidates.

Basic Goals
==========

- [ ] Using AWS Cloudformation, automate the deployment of secure, publicly available HA Load-Balanced Web Servers that return the instance id of the host that served the request.
	- Cloudformation template in /CloudFormation/ folder
	- I have provided a [Terraform](https://www.terraform.io/) version of the code too. I find Terraform to be significantly less verbose, multi-cloud aware and allows for easier code variable tokenisation.
- [x] Ensure that the web servers are available in two AWS availability zones and will automatically rebalance themselves if there is no healthy web server instance in either availability zone.
- [x] Redirect any HTTP requests to HTTPS. Self-signed certificates are acceptable.
- [x] Answer the question: "How would you further automate the management of the infrastructure if given unlimited time and resource?"
	- Create a Base AMI with Puppet installed using Packer
	- Service Discovery with Consul
	- Secrets Management with Vault (for non IAM type secrets)
	- App Build Pipeline with Jenkins/GoCD/Bamboo instead of simple TravisCI unit testing
	-
	- Create Blue:Green environments for app deployment
	- Separate App & Infrastructure management by leveraging Kubernetes or Nomad Docker Cluster
	- Integration with Splunk/Elk for logging
	- Upload Static Assets up to S3/CloudFront


Additional Challenges:
==========

- [ ] Drive the deployment with Puppet.
		Puppet Master @ https://puppet.rorychatterton.com

- [ ] Provide basic automated tests to cover included scripts, templates, manifests, recipes, code etc.
	I haven't needed to use any custom modules for Puppet, so I haven't use rspec. Desired State by design validates the machines state :)
	Small Unit Tests in Flask App

- [x] Redirect any 404 errors to a custom static page.
    - https://streamco-test.rorychatterton.com/this_url_will_fail

- [ ] Add a Database to your automation and have your application serve the data stored in addition to the instance ID.

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
