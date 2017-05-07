StreamCo DevOps Lab
==========

Technical assessment for DevOps candidates.

**App url**: https://stan.rorychatterton.com

**VM ips**: 54.179.156.179, 52.221.198.24

**DB URL**: db.stan.rorychatterton.com

**App Server Code**: https://github.com/rorychatt/Streamco-AppServer

*All Virtual Machines, Databases and Load balancers are pubically available for testing. These can be closed down with NSGs quite easily in the future*
***
### App Deployment Overview:
- Infrastructure is orchestrated with CloudFormation / Terraform.
- Puppet is bootstrapped onto the vm using aws userdata
- Puppet installs and manages docker
- Docker-Compose Runs Nginx + App Server
- RDS runs Postgres db

You can see my extremely simple flask app that returns instance_id & a table from a postgres database in **/demoapp/**

Cloudformation template is in **/CloudFormation/**.


##### Note:
The Cloudformation template only covers the *basic* 2 ALB load balanced application.

I have also included a terraform template to tackle the "additional" goals section, as I have significantly more experience with the Terraform syntax language in previous roles. It was much quicker for me to prototype in a language I'm familiar, and find the TF syntax system much nicer to work with. If you would like me to fully flesh out the Cloudformation, let me know.

Basic Goals
==========
- [x] Using AWS Cloudformation, automate the deployment of secure, publicly available HA Load-Balanced Web Servers that return the instance id of the host that served the request.
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
