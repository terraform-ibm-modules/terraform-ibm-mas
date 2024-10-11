---
copyright:
  years: [{CURRENT_YEAR}]
lastupdated: "[{LAST_UPDATED_DATE}]"

keywords:

subcollection: deployable-reference-architectures
version: 2.0.1

deployment-url: https://cloud.ibm.com/catalog/architecture/deploy-arch-ibm-mas-fc308868-e530-4605-884e-e1b3f50b3b66-global?catalog_query=aHR0cHM6Ly9jbG91ZC5pYm0uY29tL2NhdGFsb2c%2Fc2VhcmNoPW1heGltbyNzZWFyY2hfcmVzdWx0cw%3D%3D
docs: https://cloud.ibm.com/docs/maximo-application-suite

image_source: https://github.com/terraform-ibm-modules/terraform-ibm-mas/blob/main/reference-architectures/mas_deployable_architecture.svg

use-case: Automation

content-type: reference-architecture

production: true

---

{{site.data.keyword.attribute-definition-list}}

# Deployable architecture for {{site.data.keyword.prodname_imas_short}}
{: #deployable-architecture-mas-components}
{: toc-content-type="reference-architecture"}
{: toc-use-case="Automation"}
{: toc-version="2.0.1"}

The IBM Maximo Application Suite deployable architecture provides a simple automated way to get started with Maximo Application Suite on IBM Cloud. Maximo Application Suite is a set of applications for asset monitoring, management, predictive maintenance, and reliability planning. It is a single, integrated cloud-based platform that uses Artificial Intelligence (AI), Internet of Things (IoT), and analytics to optimize performance, extend asset lifecycles, and reduce operational downtime and costs.
{: shortdesc}

## Architecture diagram
{: #architecture-diagram}

![Deployable architecture diagram of Maximo Application Suite](mas_deployable_architecture.svg "Deployable architecture diagram of Maximo Application Suite"){: caption="Figure 1. Deployable architecture diagram of Maximo Application Suite" caption-side="bottom"}

## Design concepts
{: #design-concepts}

![Deployable architecture heat map of Maximo Application Suite](heat-map-mas.svg "Deployable architecture heat map of Maximo Application Suite"){: caption="Figure 2. Deployable architecture heat map of Maximo Application Suite" caption-side="bottom"}

## Requirements
{: #requirements}

The following table outlines the requirements that are addressed in this architecture."

| Aspect | Requirements |
| -------------- | -------------- |
| Compute            | Provide properly isolated compute resources with adequate compute capacity for the applications. |
| Storage            | Provide storage that meets the application and database performance requirements. |
| Networking         | Deploy workloads in isolated environment and enforce information flow policies.  \n Provide secure, encrypted connectivity to the cloud�s private network for management purposes.  \n Distribute incoming application requests across available compute resources.  \n Support failover of application to alternate site in the event of planned or unplanned outages.  \n Provide public and private DNS resolution to support use of hostnames instead of IP addresses. |
| Security           | Ensure all operator actions are executed securely through a bastion host.  \n Protect the boundaries of the application against denial-of-service and application-layer attacks.  \n Encrypt all application data in transit and at rest to protect from unauthorized disclosure.  \n Encrypt all backup data to protect from unauthorized disclosure.  \n Encrypt all security data (operational and audit logs) to protect from unauthorized disclosure.  \n Encrypt all data using customer managed keys to meet regulatory compliance requirements for additional security and customer control.  \n Protect secrets through their entire lifecycle and secure them using access control measures. |
| Resiliency         | Support application availability targets and business continuity policies.  \n Ensure availability of the application in the event of planned and unplanned outages.  \n Provide highly available compute, storage, network, and other cloud services to handle application load and performance requirements.  \n Backup application data to enable recovery in the event of unplanned outages.  \n Provide highly available storage for security data (logs) and backup data.  \n Automate recovery tasks to minimize down time |
| Service Management | Monitor system and application health metrics and logs to detect issues that might impact the availability of the application.  \n Generate alerts/notifications about issues that might impact the availability of applications to trigger appropriate responses to minimize down time.  \n Monitor audit logs to track changes and detect potential security problems.  \n Provide a mechanism to identify and send notifications about issues found in audit logs. |
{: caption="Table 1. Requirements" caption-side="bottom"}

## Components
{: #components}

The following table outlines the products or services used in the architecture for each aspect.

| Aspects | Architecture components | How the component is used |
| -------------- | -------------- | -------------- |
| Compute | PowerVS | Web, App, and database servers |
| Storage | PowerVS | Database servers shared storage for RAC |
|  | VPC Block Storage | Web app storage if neededt |
| Networking | VPC Virtual Private Network (VPN) | Remote access to manage resources in private network |
|  | Virtual Private Gateway & Virtual Private Endpoint (VPE) | For private network access to Cloud Services, e.g., Key Protect, Cloud Object Storage, etc. |
|  | VPC Load Balancers | Application Load Balancing for web servers, app servers, and database servers |
|  | Public Gateway | For web server access to the internet |
| Security | IAM | IBM Cloud Identity & Access Management |
|  | BYO Bastion Host on VPC VSI | Remote access with Privileged Access Management |
|  | Key protect or HPCS | Hardware security module (HSM) and Key Management Service |
|  | Secrets Manager | Certificate and Secrets Management |
| Resiliency | PowerVS | Multiple PowerVS on separate physical servers with VM and Storage anti-affinity policy |
| Service Management | IBM Cloud Monitoring | Apps and operational monitoring |
|  | IBM Log Analysis | Apps and operational logs |
|  | Activity Tracker Event Routing | Audit logs |
{: caption="Table 2. Components" caption-side="bottom"}
