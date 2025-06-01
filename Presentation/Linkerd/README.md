# Linkerd Laboratory — Resilience & Security with Service Mesh

This lab module explores the **resilience** and **security capabilities** of the Linkerd service mesh within a Kubernetes cluster using **Linkerd v2.13.7**.

You will deploy a simple microservice application and experiment with:
- Automatic **mutual TLS**
- **Retry budgets**
- **Failure-accrual circuit breaking**
- Real-time traffic observation using `linkerd viz`

---

## 🔧 Linkerd Version

- **Linkerd**: v2.13.7  
- **Linkerd Proxy**: `linkerd2-proxy` (written in Rust)  
- **Kubernetes**: v1.22.4  
- **CNI plugin**: Cilium (v0.16.24)

> 📌 Note: Some features like route-level timeouts and ServerPolicy are available in Linkerd ≥ 2.14, but are **not** covered in this lab version.

---

## 📁 Folder Contents

This directory includes the YAML manifests used to deploy and test Linkerd features:

| File Name            | Description |
|----------------------|-------------|
| `aura-api.yaml`      | Deploys a backend API with controllable delay and error rate |
| `web-frontend.yaml`  | Deploys a frontend that interacts with the API using curl |
| `aura-profile.yaml`  | Defines a **ServiceProfile** to enable retries and monitor specific routes |

---

## 🎯 Lab Scenario

The microservice application simulates a **stress-test environment** where the backend (`aura-api`) randomly fails or responds slowly. The frontend (`web-frontend`) issues HTTP requests to test system behavior under different conditions.

You will explore how Linkerd handles:

- Retryable routes vs non-retryable ones
- Retry budget exhaustion
- Circuit breaking when a pod continuously fails
- Encrypted communication by default via mTLS

---

## 🔐 Allowed vs Denied Traffic (via Retry & Circuit Breaker)

| **Route**         | **Condition**            | **Retryable** | **Response**          | **Behavior**                            |
|-------------------|--------------------------|---------------|------------------------|-----------------------------------------|
| `/aura`           | 40% random 500 errors     | ✅ Yes        | 200 OK (after retry)   | Retries until budget is exhausted       |
| `/slow`           | Always 200, 2–4s latency  | ✅ Yes        | 200 OK                 | No retry (no 5xx), budget remains full  |
| `/chaos`          | Always 500 errors         | ❌ No         | 500 Internal Error     | Immediately fails (no retry)            |

Once **failure accrual** is enabled, Linkerd will detect pods that always fail and **eject them from the load-balancer pool** using exponential backoff to gradually reintroduce them.

---

## 🧪 Lab Outcomes

By completing this lab, you will:

- Deploy Linkerd and inject its proxy into Kubernetes workloads
- Use `linkerd viz`, `tap`, and `routes` to inspect live traffic
- Define retryable routes and observe retry behavior
- Monitor retry budgets and protect backend services
- Enable failure accrual to block misbehaving pods
- Observe automatic mTLS in action (enabled by default in Linkerd)

---

💡 *Before starting, ensure Linkerd is installed and running properly. Inject the workloads using `linkerd inject` before applying the manifests.*
