# Host Python Application on GCP

Following is to construct a web based application on GCP using python framework. 

The architecture has been designed based on the below requirements.  

* Application to serve varied amount of traffic.
* Application avaliablity during the Datacenter failure. 
* Standby setup in case of Region Failure.
* CD without any interruption and downtime.
* Isolitaion between the environments.
* Infrastructure and application metrics, logs & security compliance.

**System Architecture**

![architecture sketch](/design/Infrastructure-design.png)

**GCP Sevices Used to build this arch:** 

* **GKE**: cluster hosted as highly avaliable with multiple avalaiblity zones. 
* **Cloud DNS:** for domain management.
* **Cloud SQL:** with private networking, communicating GKE cluster through private IP>>endpoints>>(restricted to public access)
* **Secret Manager:** to store the DB credentails(encrypted).
* **Service Account:** to access goolge API's interanlly. 



**Terraform:**
* Used to provision infrastructure. 
* **Cloud Storage:** used to store the terraform state files. 

**Pipeline Architecture**

![pipeline sketch](/design/pipeline-design.png)


**Pipeline Components:**
 
* **GITHUB:** code repo for application code, gitops repo for helm chart and to manage infrastructure. 
* **GITHUB Actions:** to provision infrastructure, and CI pipeline. 
* **Google Container Registery:** to manage docker images with vulnerability analysis. 
* **ArgoCD:** GitOps continuous delivery to deploy on Kubernetes. 


**Pre-requisites:**

* **GITHUB:** 
  - Create repositories 
        - Application code.
        - Helm Chart. 
        - Infrastructure code. 
* **GCP:** 
  - Create Project and enable billing.
  - Enable Kubernetes Engine, Google Container Registery, Cloud DNS, Cloud SQL and Secret Manager. 


**Installtion Procedure:**

  * **Infrastructure:**
  * pipeline  (secret) in repo
  * ngnix contoller / argo installtion.
  * setup to setup dns cloud and routing 
  * --- CLOUD SQL ---
  * --- TF ---- 


* local docker file test
