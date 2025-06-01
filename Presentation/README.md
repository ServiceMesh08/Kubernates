# Presentation — Quick Launch for Demos

This folder contains ready-to-run versions of the **Istio** and **Linkerd** lab environments.  
It is designed for **presentations, live demos, or fast testing**.

---

## ⚙️ What’s Inside

Each subfolder corresponds to one of the service mesh technologies used in the project:

- `Istio/`  
- `Linkerd/`

Inside each of them, you'll find:

| File Type         | Purpose                                                        |
|-------------------|----------------------------------------------------------------|
| `.sh` scripts     | Automate resource deployment and setup commands                |
| `.yaml` manifests | Kubernetes resources for services, deployments, policies, etc. |
| `.py` files       | Lightweight Python apps used to simulate microservices         |
| `Dockerfile`      | Custom container images for the demo applications              |

These assets reproduce the same scenarios described in the `Laboratory/` section, but with **faster setup** and fewer manual steps.

---

## 🧠 When to Use This

Use the `Presentation/` folder when:

- You need to **quickly showcase** the effects of mTLS, retry policies, or service denial.
- You want to **bootstrap** the system on a new Kubernetes cluster in minutes.
- You're preparing for a **talk or exam** and want to save time during setup.

---

> For full details and explanations, refer to the `Laboratory/` section.  
> This folder is meant to **accelerate execution**, not replace learning. 🚀
