# Kubernetes & Service Mesh

Welcome to the **Kubernetes & Service Mesh** lab repository!  
This project provides hands-on experience with Kubernetes (v1.22.4) and modern Service Mesh technologies such as **Istio** and **Linkerd**.

Through guided exercises and automated scripts, you’ll explore core Kubernetes concepts and apply advanced networking and security features—without changing a single line of application code.

---

## 📁 Repository Structure

The repository is organized into the following directories:

### 🔬 `Laboratory/`

This folder is intended for the full step-by-step **manual experience** of the lab.

- `Istio/`: Contains YAML manifests and instructions to experiment with mutual TLS, AuthorizationPolicies, and security policies using Istio.
- `Linkerd/`: Includes YAML files and configuration for testing resilience, observability, and circuit breaking with Linkerd.
  
Each subfolder includes a dedicated `README.md` to guide you through the specific exercises.

---

### 🚀 `Presentation/`

This folder contains **automated setups** for quick execution during live demos or classroom presentations.

- `Istio/`: Shell scripts and YAML files to quickly deploy the Istio-based lab environment, including all required microservices and policies. Dockerfiles and Python app source code are included.
- `Linkerd/`: Ready-to-run scripts and manifests for deploying the Linkerd version of the lab, featuring retry budgets, failure accrual, and automatic mTLS.
- `ClusterSetup/`: Scripts and instructions to bootstrap a Kubernetes cluster from scratch using `kubeadm`, install Cilium as the CNI plugin, and prepare the environment for Service Mesh deployment.

These resources are ideal for instructors, presenters, or anyone who wants to skip straight to a running setup.

---

## 🧠 What You Will Learn

- How to set up a Kubernetes cluster and configure a CNI plugin (Cilium)
- Kubernetes essentials: Pods, Deployments, Services, Namespaces
- How Service Meshes enhance Kubernetes with zero-trust security and observability
- Hands-on practice with Istio: mTLS, RBAC, and traffic authorization
- Hands-on practice with Linkerd: retry budgets, circuit breaking, and metrics
- How to debug and observe microservice traffic with real-time CLI tools

---

> This lab was created for educational purposes at the Politecnico di Torino (April 2025) and is now open for learning, exploration, and sharing 🚀

---
