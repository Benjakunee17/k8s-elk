# k8s-elk
This diagram shows a centralized logging architecture where application and system logs are collected from a local Kubernetes cluster and sent to the Elastic Stack running on an AWS EC2 instance.

On the left side, the local Kubernetes cluster runs application pods that generate logs. Fluent Bit is deployed inside the cluster as the log collector. It reads container logs from the Kubernetes nodes, processes them, and forwards them securely over the network.

In the middle, the logs travel through the internet from the local environment to AWS.

On the right side, the Elastic Stack is hosted on an EC2 instance. Elasticsearch stores and indexes the incoming logs, making them searchable. Kibana connects to Elasticsearch and provides a web interface for viewing, filtering, and analyzing the logs. This allows operators to monitor application behavior, investigate errors, and troubleshoot issues from a single centralized dashboard.

In short, the flow is:

Kubernetes Pods → Fluent Bit → Internet → Elasticsearch on EC2 → Kibana

This setup is useful because it separates the workload environment from the logging platform, provides centralized visibility, and makes monitoring and troubleshooting much easier across the whole system.
