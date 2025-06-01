# Laboratory — Hands-On Exploration

This folder contains the **full lab activities** for exploring Kubernetes and Service Mesh technologies through a hands-on approach.

Each subfolder is dedicated to one of the two service mesh platforms used in the course and includes all the necessary YAML manifests and configuration files to manually perform the step-by-step exercises.

---

## 📁 Subfolders Overview

### `Istio/` — Zero Trust & Security Policies

This lab focuses on securing communication within a Kubernetes cluster using **Istio v1.16.7**.  
You will:

- Enable **Mutual TLS (mTLS)** across services
- Apply **AuthorizationPolicies** to control access
- Simulate real-world microservice interactions in a secure environment

The lab uses a scenario based on exam booking, involving students and professors with different permissions.

👉 For full details, see the [`Istio/README.md`](./Istio/README.md)

---

### `Linkerd/` — Resilience & Observability

This lab introduces the reliability and observability features of **Linkerd v2.13.7**.  
You will:

- Apply **retry budgets** and explore retry logic
- Use **failure accrual** to eject unhealthy pods
- Monitor service traffic in real time with `linkerd viz`

The lab simulates a backend that occasionally fails or slows down, helping you observe how Linkerd handles these conditions.

👉 For full details, see the [`Linkerd/README.md`](./Linkerd/README.md)

---
