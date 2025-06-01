# Istio Laboratory — Security with Service Mesh

This lab module focuses on securing microservice communication within a Kubernetes cluster using **Istio v1.16.7**.

You will learn how to enforce **Mutual TLS (mTLS)** and define **AuthorizationPolicies** in order to control traffic between services. The configuration is applied at runtime using Kubernetes YAML manifests and Istio resources.

## 🔧 Istio Version

- **Istio**: v1.16.7  
- **Envoy Proxy**: included in Istio as the sidecar data plane  
- **Kubernetes**: v1.22.4  
- **CNI plugin**: Cilium (v0.16.24) must be installed beforehand

---

## 📁 Folder Contents

This directory contains the following files and resources:

| File Name                | Description |
|--------------------------|-------------|
| `exam-scheduler.yaml`    | Deploys the backend service (exam scheduler) and its ServiceAccount |
| `student-portal.yaml`    | Deploys a client pod representing the student interface |
| `professor-tools.yaml`   | Deploys a client pod representing the professor interface |
| `peer-authn.yaml`        | Enables **Mutual TLS** in the namespace (`STRICT` mode) |
| `authz-scheduler.yaml`   | Allows only specific services to access `exam-scheduler` |
| `authz-student.yaml`     | Blocks all inbound traffic to `student-portal` |
| `authz-professor.yaml`   | Blocks all inbound traffic to `professor-tools` |

---

## 🎯 Lab Scenario

You will simulate a **microservice architecture** used to manage exam bookings in a university environment. The system includes:

- **exam-scheduler**: Manages exam registrations (backend)
- **student-portal**: Allows students to register for exams
- **professor-tools**: Allows professors to view registered students

Once deployed, you will implement **zero-trust principles** by:

1. Enforcing mutual TLS (so that only verified services can talk to each other)
2. Defining strict Authorization Policies to allow only specific interactions

---

## 🔐 Allowed vs Denied Traffic

| **Source**         | **Destination**     | **Method** | **Access**       | **Reason**                                      |
|--------------------|---------------------|------------|------------------|-------------------------------------------------|
| student-portal     | exam-scheduler      | POST       | ✅ Allowed        | To register students for an exam                |
| student-portal     | professor-tools     | *          | ❌ Denied        | To prevent unauthorized access to sensitive data |
| professor-tools    | exam-scheduler      | GET        | ✅ Allowed        | To retrieve list of registered students         |
| *                  | student-portal      | *          | ❌ Denied        | To avoid scraping or unsolicited access         |

> Any attempt to bypass these rules (e.g., using a non-meshed pod) will be automatically blocked by Istio once mTLS and AuthorizationPolicies are enforced.

---

## 🧪 Lab Outcomes

By the end of this lab, you will be able to:

- Enable and verify **mTLS** communication in a Kubernetes namespace
- Create and apply **fine-grained access control rules** using Istio’s `AuthorizationPolicy`
- Test and debug request flows with `curl` from inside Pods
- Understand the flow of secure communication inside a service mesh

---

💡 *Before starting, make sure that Istio is properly installed and the namespace is labeled with `istio-injection=enabled`.*
