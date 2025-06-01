# Kubernetes & Service Mesh

Welcome to the **Kubernetes & Service Mesh** lab repository!  
This project provides hands-on experience with Kubernetes (v1.22.4) and two leading service mesh technologies: **Istio** and **Linkerd**.

Through practical scenarios and live simulations, you'll learn how to deploy and secure containerized applications using service meshes—**without touching the application code**. The lab is ideal for students, professionals, or educators who want to explore zero-trust networking, observability, and resiliency patterns.

---

## 📁 Repository Structure

The repository is structured into the following directories:

### 🔬 `Laboratory/`

This folder is intended for the full step-by-step **manual experience** of the lab.

- `Istio/`: Contains YAML manifests and instructions to experiment with mutual TLS, AuthorizationPolicies, and security policies using Istio.
- `Linkerd/`: Includes YAML files and configuration for testing resilience, observability, and circuit breaking with Linkerd.
  
Each subfolder includes a dedicated `README.md` to guide you through the specific exercises.

---

### 🚀 `Presentation/`

This folder contains **automated setups** for quick execution during live demos or classroom presentations.

- `Istio/`: 
  - `IstioSetup.sh`: a script to instantly deploy the Istio-based lab.
  - `YamlCreation.yaml`: a complete setup with PeerAuthentication and AuthorizationPolicies.
  - `Dockerfile` and `app.py`: Python microservice for mTLS and RBAC testing.

- `Linkerd/`:  
  - `LinkerdSetup.sh`: ready-to-run script for launching the Linkerd environment.
  - `YamlCreation.yaml`: includes ServiceProfile, retry budgets, failure accrual settings.
  - `Dockerfile` and `app.py`: app + client to simulate traffic and failure handling.

Each folder enables a **quick-launch environment** with prebuilt configurations—perfect for exams, workshops, and demos.

---

## 🚀 Technologies Used

- **Kubernetes** v1.22.4  
- **Istio** v1.16.7  
- **Linkerd** v2.13  
- **CNI Plugin**: Cilium v0.16.24  
- **Envoy** (Istio) & **Linkerd2-Proxy** (Linkerd)  
- **Demo apps**: `curlimages/curl`, `busyboxplus`, `hashicorp/http-echo`

---

## 🎯 Learning Objectives

- Set up a Kubernetes cluster with a custom CNI (Cilium)
- Master Kubernetes fundamentals: Pods, Deployments, Namespaces, Services
- Understand how service meshes enhance Kubernetes with observability, security, and traffic control
- Apply **Istio** features: mTLS, AuthorizationPolicies, sidecar injection
- Use **Linkerd** features: retry budget, failure accrual, and automatic mTLS
- Inspect real-time traffic using `kubectl`, `istioctl`, and `linkerd viz` commands

---

> This lab was created for educational purposes at **Politecnico di Torino** and is now open for learning and exploration.
